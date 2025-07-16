import 'package:flutter/material.dart';

class LoginBotton extends StatelessWidget {
  const LoginBotton({super.key, required this.way});

  final String way;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff5B5A56),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 145),
        child: Text(way, style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }
}
