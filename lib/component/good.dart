import 'package:flutter/material.dart';

class Good extends StatelessWidget {
  const Good({super.key, required this.level, required this.time});

  final String level;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff5A5856),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, top: 11, bottom: 11, right: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(level, style: TextStyle(fontSize: 15, color: Colors.white)),
            Text(
              time,
              style: TextStyle(fontSize: 12, color: Color(0xffC0C0C0)),
            ),
          ],
        ),
      ),
    );
  }
}
