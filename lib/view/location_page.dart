import 'package:camposs/component/check.dart';
import 'package:camposs/component/adventure.dart';
import 'package:camposs/component/location_text.dart';
import 'package:camposs/view/start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
            Check(),
            // LocationText(),
            SizedBox(height: 36.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.fiber_manual_record, color: Colors.white),
                SizedBox(width: 15.w),
                Icon(Icons.fiber_manual_record, color: Color(0xff5A5856)),
                SizedBox(width: 15.w),
              ],
            ),
            SizedBox(height: 76.h),
            Adventure(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StartPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
