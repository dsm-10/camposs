import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationText extends StatelessWidget {
  final String distance;

  const LocationText({super.key, required this.distance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 43),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              text: '50m\n',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: distance,
                  style: TextStyle(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: 'm',
                  style: TextStyle(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff93928B),
                  ),
                ),
                TextSpan(
                  text: '\n사용자의',
                  style: TextStyle(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff93928B),
                  ),
                ),
                TextSpan(
                  text: ' 오른쪽',
                  style: TextStyle(
                    fontSize: 35.sp,
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
