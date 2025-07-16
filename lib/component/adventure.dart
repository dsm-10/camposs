import 'package:flutter/material.dart';

class Adventure extends StatelessWidget {
  const Adventure({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff5A5856),
        borderRadius: BorderRadius.circular(40)
      ),
      child: Row(
        children: [
          SizedBox(height: 36,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 21,horizontal: 102),
            child: Row(
                children: [
              Icon(Icons.map_outlined,color: Colors.white,),
              SizedBox(width: 13,),
                  Text('모험 시작',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.white),),
          ]),
          ),
        ],
      ),
    );
  }
}
