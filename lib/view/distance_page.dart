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
  Future<Map<String, dynamic>> _start() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    num latitude = position.latitude, longitude = position.longitude;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(ConstValues.tokenKey) ?? '';

    Dio dio = Dio();

    try {
      final response = await dio.get(
        '${ConstValues.BaseURL2}/compass/next',
        queryParameters: {'lat': latitude, 'lon': longitude},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 401) {
        throw Exception('Unauthorized error: 401');
      } else if (response.statusCode == 400) {
        throw Exception('Bad Request error: 400');
      }

      if (response.data is String) {
        final parsed = json.decode(response.data);
        if (parsed is Map<String, dynamic>) {
          return parsed;
        } else {
          throw Exception();
        }
      }

      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else {
        throw Exception();
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _start(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data!['distance']);
          return Scaffold(
            backgroundColor: Color(0xff1E1E1E),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Now(when: '현재 위치'),
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 0),
                  child: Check(),
                ),
                LocationText(distance: snapshot.data!['distance'].toString()),
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
                            MaterialPageRoute(
                              builder: (context) => const MyPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Color(0xff1E1E1E),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text("ERROR 났음")],
            ),
          );
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
