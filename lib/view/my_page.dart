import 'package:camposs/component/collect.dart';
import 'package:camposs/component/my_button.dart';
import 'package:camposs/component/out_botton.dart';
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 43, horizontal: 43),
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
            SizedBox(height: 30),
            Collect(level: '1. 역사박사', count: '9개'),
            SizedBox(height: 13),
            Collect(level: '2.지존역사박사', count: '5개'),
            SizedBox(height: 13),
            Collect(level: '3.좋은 역사박사', count: '2개'),
            SizedBox(height: 13),
            Collect(level: '4.유망주', count: '1개'),
            SizedBox(height: 410),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [OutBotton(), MyButton()],
            ),
          ],
        ),
      ),
    );
  }
}
