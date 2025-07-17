import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../component/check.dart';
import '../component/location_text.dart';
import '../component/my_button.dart';
import '../component/now.dart';
import '../component/util.dart';
import 'my_page.dart';

class DistancePage extends StatefulWidget {
  const DistancePage({super.key});

  @override
  State<DistancePage> createState() => _DistancePageState();
}

class _DistancePageState extends State<DistancePage> {
  double? targetLat;
  double? targetLon;
  double? currentDistance;
  StreamSubscription<Position>? positionStream;
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _fetchTargetAndTrack();
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  Future<Map<String, dynamic>> _start() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(ConstValues.tokenKey) ?? '';

    Dio dio = Dio();

    final response = await dio.get(
      '${ConstValues.BaseURL2}/compass/next',
      queryParameters: {'lat': position.latitude, 'lon': position.longitude},
      options: Options(
        headers: {'Authorization': 'Bearer $accessToken'},
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
      return response.data;
    } else {
      throw Exception("서버 통신 실패");
    }
  }

  Future<void> _fetchTargetAndTrack() async {
    try {
      final target = await _start();
      targetLat = target['latitude'];
      targetLon = target['longitude'];

      // 현재 거리도 한 번 계산
      Position initialPosition = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );
      currentDistance = Geolocator.distanceBetween(
        initialPosition.latitude,
        initialPosition.longitude,
        targetLat!,
        targetLon!,
      );

      // 실시간 추적 시작
      positionStream =
          Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
            ),
          ).listen((Position pos) {
            double dist = Geolocator.distanceBetween(
              pos.latitude,
              pos.longitude,
              targetLat!,
              targetLon!,
            );

            setState(() {
              currentDistance = dist;
            });
          });

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("오류 발생: $e");
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xff1E1E1E),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (isError) {
      return const Scaffold(
        backgroundColor: Color(0xff1E1E1E),
        body: Center(child: Text("ERROR 났음")),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xff1E1E1E),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Now(when: '현재 위치'),
          Check(),
          LocationText(
            distance: currentDistance != null
                ? currentDistance!.toStringAsFixed(2)
                : '계산 중...',
          ),
          SizedBox(height: 60.h),
          Padding(
            padding: EdgeInsets.only(left: 43.w),
            child: Row(
              children: [
                SizedBox(width: 121.w),
                MyButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
