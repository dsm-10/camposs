import 'package:camposs/component/collect.dart';
import 'package:camposs/component/my_button.dart';
import 'package:camposs/component/out_botton.dart';
import 'package:camposs/view/distance_page.dart';
import 'package:camposs/view/my_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RangkingPage extends StatelessWidget {
  const RangkingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 43.h, horizontal: 43.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '랭킹 순위',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xff93928B),
              ),
            ),
            Text(
              '전체 유적 보유 순위',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30.h),
            Collect(level: '1. 역사박사', count: '9개'),
            SizedBox(height: 13.h),
            Collect(level: '2.지존역사박사', count: '5개'),
            SizedBox(height: 13.h),
            Collect(level: '3.좋은 역사박사', count: '2개'),
            SizedBox(height: 13.h),
            Collect(level: '4.유망주', count: '1개'),
            SizedBox(height: 410.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutBotton(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => DistancePage()),
                      (route) => false,
                    );
                  },
                ),
                MyButton(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyPage()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
