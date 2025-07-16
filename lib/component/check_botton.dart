import 'package:flutter/material.dart';

class CheckBotton extends StatelessWidget {
  const CheckBotton({super.key, required this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color(0xff5A5856),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 17),
          child: Icon(Icons.check, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}
