import 'package:flutter/material.dart';

class Titles extends StatelessWidget {
  const Titles({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('역사의',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w400),),
        Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Text('나침반',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w400),),
        ),
      ],
    );
  }
}
