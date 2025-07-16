import 'package:camposs/component/now.dart';
import 'package:camposs/component/relics.dart';
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
          Text('네더 유물', style: TextStyle(fontSize: 35, color: Colors.white)),
          Text(
            '이것은 마인크래프트에서 나온 네더유물입니다.이것은 마인크래프트에서 나온 네더유물입니다.이것은 마인크래프트에서 나온 네더유물입니다.이것은 마인크래프트에서 나온 네더유물입니다.이것은 마인크래프트에서 나온 네더유물입니다.',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
