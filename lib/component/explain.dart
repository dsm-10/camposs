import 'package:flutter/material.dart';

class Explain extends StatelessWidget {
  const Explain({super.key, required this.name, required this.explain});

  final String name;
  final String explain;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 43, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(color: Colors.white, fontSize: 35)),
          SizedBox(height: 15),
          Text(
            explain,
            style: TextStyle(color: Color(0xff93928B), fontSize: 20),
          ),
        ],
      ),
    );
  }
}
