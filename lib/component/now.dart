import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Now extends StatelessWidget {
  const Now({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 43.w, top: 43.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '현재 위치',
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff93928B),
            ),
          ),
          Text(
            '유성구 가정북로 76',
            style: TextStyle(
              fontSize: 30.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
