import 'package:camposs/component/good.dart';
import 'package:camposs/component/lanking_botton.dart';
import 'package:camposs/component/out_botton.dart';
import 'package:flutter/material.dart';

class LankingPage extends StatelessWidget {
  const LankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 43, vertical: 43),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '현재 순위',
              style: TextStyle(color: Color(0xff93928B), fontSize: 16),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
                    text: '2등:',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  TextSpan(
                    text: ' 1등과 유물 1개 차이',
                    style: TextStyle(fontSize: 20, color: Color(0xff93928B)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              '나의 소유물',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 13),
            Good(level: '정말 신기한 유물', time: '1일전'),
            SizedBox(height: 13),
            Good(level: '평범한 유물', time: '하루 전'),
            SizedBox(height: 13),
            Good(level: '희귀한 유물', time: '한달 전'),
            SizedBox(height: 280),
            RichText(
              text: TextSpan(
                style: TextStyle(),
                children: const <TextSpan>[
                  TextSpan(
                    text: '0',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: 'm\n',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 50,
                      color: Color(0xff93928B),
                    ),
                  ),
                  TextSpan(
                    text: '닉네임님의',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 50,
                      color: Color(0xff93928B),
                    ),
                  ),
                  TextSpan(
                    text: ' 홈',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 50),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [OutBotton(), LankingBotton()],
            ),
          ],
        ),
      ),
    );
  }
}
