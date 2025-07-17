import 'package:camposs/component/adventure.dart';
import 'package:camposs/component/relics.dart';
import 'package:camposs/component/start_text.dart';
import 'package:camposs/view/distance_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Relics(),
          SizedBox(height: 57.h),
          StartText(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Row(
                  children: [
                    SizedBox(height: 107.h),
                    Icon(
                      Icons.fiber_manual_record,
                      color: Color(0xff5A5856),
                      size: 12.sp,
                    ),
                    SizedBox(width: 15.w),
                    Icon(
                      Icons.fiber_manual_record,
                      color: Colors.white,
                      size: 12.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Adventure(
            onTap: () async {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => DistancePage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
