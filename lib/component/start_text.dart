import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartText extends StatelessWidget {
  const StartText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '대한민국',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 49.5.sp,
            ),
          ),
          TextSpan(
            text: '의\n',
            style: TextStyle(
              fontSize: 46.2.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff93928B),
            ),
          ),
          TextSpan(
            text: '유적을 모으세요!',
            style: TextStyle(color: Color(0xff93928B), fontSize: 46.2.sp),
          ),
        ],
      ),
    );
  }
}
