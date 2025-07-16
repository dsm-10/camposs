import 'package:flutter/material.dart';

class LankingBotton extends StatelessWidget {
  const LankingBotton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff5A5856),
          borderRadius: BorderRadius.circular(90),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
          child: Image.asset('asset/images/rank.png'),
        ),
      ),
    );
  }
}
