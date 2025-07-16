import 'package:camposs/component/check.dart';
import 'package:camposs/component/check_botton.dart';
import 'package:camposs/component/location_text.dart';
import 'package:camposs/component/my_button.dart';
import 'package:camposs/component/now.dart';
import 'package:flutter/material.dart';

class DistancePage extends StatelessWidget {
  const DistancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Now(when: '현재 위치'),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 0),
            child: Check(),
          ),
          LocationText(),
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.only(left: 43),
            child: Row(
              children: [CheckBotton(), SizedBox(width: 121), MyButton()],
            ),
          ),
        ],
      ),
    );
  }
}
