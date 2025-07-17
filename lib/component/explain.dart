import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Explain extends StatelessWidget {
  const Explain({super.key, required this.name, required this.explain});

  final String name;
  final String explain;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 43.w, right: 23.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: 35.sp),
          ),
          SizedBox(height: 15.h),
          Text(
            explain,
            style: TextStyle(color: Color(0xff93928B), fontSize: 20.sp),
          ),
        ],
      ),
    );
  }
}
