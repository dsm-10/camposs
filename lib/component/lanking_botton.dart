import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LankingBotton extends StatelessWidget {
  const LankingBotton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff5A5856),
          borderRadius: BorderRadius.circular(90.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.h),
          child: Image.asset('asset/images/rank.png', width: 38.81.w),
        ),
      ),
    );
  }
}
