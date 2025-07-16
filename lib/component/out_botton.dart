import 'package:flutter/material.dart';

class OutBotton extends StatelessWidget {
  const OutBotton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: Color(0xff5A5856),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Icon(Icons.close, color: Colors.white, size: 40),
        ),
      ),
    );
  }
}
