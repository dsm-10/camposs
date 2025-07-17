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
  double heading = 0.0; // UI가 가리켜야 하는 방향
  double phoneHeading = 0.0; // 기기가 바라보는 방향
  double _currentLat = 0.0;
  double _currentLon = 0.0;

  StreamSubscription<Position>? positionStream;
  StreamSubscription<CompassEvent>? compassStream;
  bool isLoading = true;
  bool isError = false;
  Timer? _updateTimer;
  double? lastHeading;

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
    compassStream = FlutterCompass.events!.listen((event) {
      if (!mounted || event.heading == null) return;

      final newHeading = event.heading!;
      if (lastHeading == null || (newHeading - lastHeading!).abs() > 1.0) {
        lastHeading = newHeading;
        phoneHeading = newHeading;

        if (targetLat != null && targetLon != null) {
          final bearing = calculateBearing(
            _currentLat,
            _currentLon,
            targetLat!,
            targetLon!,
          );
          final relative = calculateRelativeHeading(bearing);

          setState(() {
            heading = relative;
          });
        }
      }
    });
  }

  double calculateRelativeHeading(double targetBearing) {
    return (targetBearing - phoneHeading + 360) % 360;
  }

  double calculateBearing(double lat1, double lon1, double lat2, double lon2) {
    final dLon = (lon2 - lon1) * (pi / 180);
    final lat1Rad = lat1 * (pi / 180);
    final lat2Rad = lat2 * (pi / 180);

    final y = sin(dLon) * cos(lat2Rad);
    final x =
        cos(lat1Rad) * sin(lat2Rad) - sin(lat1Rad) * cos(lat2Rad) * cos(dLon);

    double bearing = atan2(y, x) * (180 / pi);
    return (bearing + 360) % 360;
  }

  String getDirectionText(double heading) {
    if (heading >= 315 || heading < 45) {
      return '앞';
    } else if (heading >= 45 && heading < 135) {
      return '오른쪽';
    } else if (heading >= 135 && heading < 225) {
      return '뒤';
    } else {
      return '왼쪽';
    }
  }

  Future<Map<String, dynamic>> _start() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _currentLat = position.latitude;
    _currentLon = position.longitude;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(ConstValues.tokenKey) ?? '';

    Dio dio = Dio();

    final response = await dio.get(
      '${ConstValues.BaseURL2}/compass/next',
      queryParameters: {'lat': _currentLat, 'lon': _currentLon},
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

      final initialPos = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );
      _currentLat = initialPos.latitude;
      _currentLon = initialPos.longitude;

      final initialDistance = Geolocator.distanceBetween(
        _currentLat,
        _currentLon,
        targetLat!,
        targetLon!,
      );

      final initialBearing = calculateBearing(
        _currentLat,
        _currentLon,
        targetLat!,
        targetLon!,
      );

      setState(() {
        currentDistance = initialDistance;
        heading = calculateRelativeHeading(initialBearing);
        isLoading = false;
      });

      double lastUpdateDistance = initialDistance;

      positionStream =
          Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 5,
            ),
          ).listen((Position pos) {
            if (!mounted) return;

            _currentLat = pos.latitude;
            _currentLon = pos.longitude;

            final dist = Geolocator.distanceBetween(
              _currentLat,
              _currentLon,
              targetLat!,
              targetLon!,
            );

            final absoluteBearing = calculateBearing(
              _currentLat,
              _currentLon,
              targetLat!,
              targetLon!,
            );

            final relativeBearing = calculateRelativeHeading(absoluteBearing);

            if ((dist - lastUpdateDistance).abs() > 3.0) {
              _updateTimer?.cancel();
              _updateTimer = Timer(const Duration(milliseconds: 300), () {
                if (!mounted) return;

                setState(() {
                  currentDistance = dist;
                  heading = relativeBearing;
                });

                lastUpdateDistance = dist;
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
          SizedBox(height: 43.h),
          Now(),
          SizedBox(height: 100.h),
          Center(
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              turns: heading / 360.0,
              child: Image.asset('asset/images/Frame.png', width: 150.w),
            ),
          ),
          SizedBox(height: 100.h),
          LocationText(
            distance: currentDistance != null
                ? currentDistance!.toStringAsFixed(2)
                : '계산 중...',
            direction: getDirectionText(heading),
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.only(right: 30.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
