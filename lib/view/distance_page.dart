import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  double heading = 0.0;
  double phoneHeading = 0.0;
  StreamSubscription<Position>? positionStream;
  StreamSubscription<CompassEvent>? compassStream;
  bool isLoading = true;
  bool isError = false;
  Timer? _updateTimer;

  @override
  void initState() {
    super.initState();
    _fetchTargetAndTrack();
    _startCompassTracking();
  }

  @override
  void dispose() {
    positionStream?.cancel();
    compassStream?.cancel();
    _updateTimer?.cancel();
    super.dispose();
  }

  void _startCompassTracking() {
    compassStream = FlutterCompass.events!.listen((CompassEvent event) {
      if (!mounted) return;

      if (event.heading != null) {
        setState(() {
          phoneHeading = event.heading!;
        });
      }
    });
  }

  double calculateRelativeHeading(double targetBearing) {
    return (targetBearing - phoneHeading + 360) % 360;
  }

  double calculateBearing(double lat1, double lon1, double lat2, double lon2) {
    final double dLon = (lon2 - lon1) * (pi / 180);
    final double lat1Rad = lat1 * (pi / 180);
    final double lat2Rad = lat2 * (pi / 180);

    final double y = sin(dLon) * cos(lat2Rad);
    final double x =
        cos(lat1Rad) * sin(lat2Rad) - sin(lat1Rad) * cos(lat2Rad) * cos(dLon);

    double bearing = atan2(y, x);
    bearing = bearing * (180 / pi);
    return (bearing + 360) % 360;
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

      Position initialPosition = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );

      double initialDistance = Geolocator.distanceBetween(
        initialPosition.latitude,
        initialPosition.longitude,
        targetLat!,
        targetLon!,
      );

      double initialBearing = calculateBearing(
        initialPosition.latitude,
        initialPosition.longitude,
        targetLat!,
        targetLon!,
      );

      setState(() {
        currentDistance = initialDistance;
        heading = calculateRelativeHeading(initialBearing);
        isLoading = false;
      });

      double lastUpdateHeading = heading;
      double lastUpdateDistance = initialDistance;

      positionStream =
          Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 5,
            ),
          ).listen((Position pos) {
            if (!mounted) return;

            double dist = Geolocator.distanceBetween(
              pos.latitude,
              pos.longitude,
              targetLat!,
              targetLon!,
            );

            double absoluteBearing = calculateBearing(
              pos.latitude,
              pos.longitude,
              targetLat!,
              targetLon!,
            );

            double relativeBearing = calculateRelativeHeading(absoluteBearing);

            if ((relativeBearing - lastUpdateHeading).abs() > 10.0 ||
                (dist - lastUpdateDistance).abs() > 3.0) {
              _updateTimer?.cancel();
              _updateTimer = Timer(const Duration(milliseconds: 500), () {
                if (mounted) {
                  setState(() {
                    currentDistance = dist;
                    heading = relativeBearing;
                  });
                  lastUpdateHeading = relativeBearing;
                  lastUpdateDistance = dist;

                  print(
                    "📍 방향: $relativeBearing도 | turns: ${relativeBearing / 360.0}",
                  );
                }
              });
            }
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
          Padding(
            padding: EdgeInsets.all(100.sp),
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 800),
              turns: heading / 360.0,
              child: Image.asset('asset/images/Frame.png', width: 100.w),
            ),
          ),
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
