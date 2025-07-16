import 'package:camposs/component/explain.dart';
import 'package:camposs/component/my_button.dart';
import 'package:camposs/component/now.dart';
import 'package:camposs/component/out_botton.dart';
import 'package:camposs/component/relics.dart';
import 'package:camposs/view/distance_page.dart';
import 'package:camposs/view/my_page.dart';
import 'package:camposs/view/rangking_page.dart';
import 'package:flutter/material.dart';

class ExplainPage extends StatelessWidget {
  const ExplainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Now(when: '도착 위치'),
          SizedBox(height: 72),
          Padding(padding: const EdgeInsets.only(left: 83), child: Relics()),
          Explain(
            name: '네더유물',
            explain:
                '안녕하세요 안녕하세요 안녕하세요 안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요',
          ),
          SizedBox(height: 160),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 43),
                child: OutBotton(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => DistancePage()),
                      (route) => false,
                    );
                  },
                ),
              ),
              SizedBox(width: 206),
              MyButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyPage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
