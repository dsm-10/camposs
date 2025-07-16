import 'package:flutter/material.dart';

class StartText extends StatelessWidget {
  const StartText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 40),
        children: <TextSpan>[
          TextSpan(
            text: '대한민국',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          ),
          TextSpan(
            text: '의\n',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Color(0xff93928B),
            ),
          ),
          TextSpan(
            text: '유적을 모으세요!',
            style: TextStyle(color: Color(0xff93928B)),
          ),
        ],
      ),
    );
  }
}
