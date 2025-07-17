import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutBotton extends StatelessWidget {
  const OutBotton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90.r),
          color: Color(0xff5A5856),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.h),
          child: Icon(Icons.close, color: Colors.white, weight: 38.81.sp),
        ),
      ),
    );
  }
}
