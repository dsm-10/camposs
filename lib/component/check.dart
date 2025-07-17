import 'package:camposs/view/explain_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Check extends StatelessWidget {
  final String id;

  const Check({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ExplainPage(heritageId: id)),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Color(0xFF5A5856),
          borderRadius: BorderRadius.all(Radius.circular(10000.r)),
        ),
        child: Icon(Icons.check, color: Colors.white, size: 28.sp),
      ),
    );
  }
}
