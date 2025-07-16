import 'package:flutter/material.dart';

class OutBotton extends StatelessWidget {
  const OutBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        color: Color(0xff5A5856),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Icon(Icons.close, color: Colors.white, size: 40),
      ),
    );
  }
}
