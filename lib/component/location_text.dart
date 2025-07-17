import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationText extends StatelessWidget {
  final String distance;
  final String direction;

  const LocationText({
    super.key,
    required this.distance,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 43),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: distance,
                  style: TextStyle(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: 'm',
                  style: TextStyle(
                    fontSize: 45.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff93928B),
                  ),
                ),
                TextSpan(
                  text: '\n사용자의',
                  style: TextStyle(
                    fontSize: 45.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff93928B),
                  ),
                ),
                TextSpan(
                  text: ' $direction',
                  style: TextStyle(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
