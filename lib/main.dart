import 'package:camposs/view/distance_page.dart';
import 'package:camposs/view/location_page.dart';
import 'package:camposs/view/login_page.dart';
import 'package:camposs/view/start_page.dart';
import 'package:camposs/view/user_join_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const DistancePage(),
    );
  }
}
