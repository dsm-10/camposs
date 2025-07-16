import 'package:camposs/component/util.dart';
import 'package:camposs/view/distance_page.dart';
import 'package:camposs/view/location_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../component/login_botton.dart';
import '../component/text_field.dart';
import '../component/title.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController nicknameController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nicknameController = TextEditingController();
    passwordController = TextEditingController();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    nicknameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // 위치 권한 확인 및 요청
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    } catch (e) {
      throw Exception('위치 정보 거절 당함');
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<String> _login({
      required String nickname,
      required String password,
    }) async {
      Dio dio = Dio();

      try {
        final response = await dio.post(
          '${ConstValues.BaseURL}/auth/login',
          data: {'nickname': nickname, 'password': password},
        );

        return response.data['token'];
      } catch (err) {
        throw Exception(err);
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xff1E1E1E),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 41),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 213),
              Titles(),
              SizedBox(height: 86),
              TextsField(
                textEditingController: nicknameController,
                hintText: '아이디를 입력하세요.',
                obsText: false,
                suffixIcon: null,
                errorText: '',
              ),
              SizedBox(height: 41),
              TextsField(
                textEditingController: passwordController,
                hintText: '비밀번호를 입력하세요.',
                obsText: true,
                suffixIcon: Icon(Icons.visibility_off_outlined),
                errorText: '다시 확인해주세요',
              ),
              SizedBox(height: 208),
              GestureDetector(
                onTap: () async {
                  final String token = await _login(
                    nickname: nicknameController.text,
                    password: passwordController.text,
                  );

                  if (token.isNotEmpty) {
                    try {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString(ConstValues.tokenKey, token);
                    } catch (err) {
                      print(err);
                    }
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LocationPage()),
                      (route) => false,
                    );
                  }
                },
                child: LoginBotton(way: '로그인'),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
