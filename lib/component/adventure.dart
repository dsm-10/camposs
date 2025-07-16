import 'package:camposs/view/start_page.dart';
import 'package:flutter/material.dart';

class Adventure extends StatelessWidget {
  const Adventure({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff5A5856),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            SizedBox(height: 36),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 21, horizontal: 102),
              child: Row(
                children: [
                  Icon(Icons.map_outlined, color: Colors.white),
                  SizedBox(width: 13),
                  Text(
                    '모험 시작',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
