import 'package:camposs/component/adventure.dart';
import 'package:camposs/component/relics.dart';
import 'package:camposs/component/start_text.dart';
import 'package:camposs/view/distance_page.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 192,
          left: 60,
          right: 60,
          bottom: 55,
        ),
        child: Column(
          children: [
            Relics(),
            SizedBox(height: 57),
            StartText(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Row(
                    children: [
                      SizedBox(height: 107),
                      Icon(Icons.fiber_manual_record, color: Color(0xff5A5856)),
                      SizedBox(width: 15),
                      Icon(Icons.fiber_manual_record, color: Colors.white),
                      SizedBox(width: 15),
                      Icon(Icons.fiber_manual_record, color: Color(0xff5A5856)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 76),
            Adventure(
              onTap: () async {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DistancePage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
