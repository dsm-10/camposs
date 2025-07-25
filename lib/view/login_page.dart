import 'package:camposs/component/util.dart';
import 'package:camposs/view/distance_page.dart';
import 'package:camposs/view/user_join_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  bool isLoading = false, pwObsText = true;

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

  Future<String> _login({
    required String nickname,
    required String password,
  }) async {
    setState(() => isLoading = true);

    Dio dio = Dio();

    try {
      final response = await dio.post(
        '${ConstValues.BaseURL}/auth/login',
        data: {'nickname': nickname, 'password': password},
      );

      setState(() => isLoading = false);
      return response.data['token'];
    } catch (err) {
      setState(() => isLoading = false);
      throw Exception(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff1E1E1E),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 41.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 213.h),
                Titles(),
                SizedBox(height: 86.h),
                TextsField(
                  textEditingController: nicknameController,
                  hintText: '아이디를 입력하세요.',
                  obsText: false,
                  suffixIcon: null,
                  errorText: '',
                ),
                SizedBox(height: 20.h),
                TextsField(
                  textEditingController: passwordController,
                  hintText: '비밀번호를 입력하세요.',
                  obsText: pwObsText,
                  suffixIcon: GestureDetector(
                    onTap: () => setState(() => pwObsText = !pwObsText),
                    child: Builder(
                      builder: (context) {
                        if (pwObsText) {
                          return Icon(Icons.visibility);
                        } else {
                          return Icon(Icons.visibility_off_outlined);
                        }
                      },
                    ),
                  ),
                  errorText: '다시 확인해주세요',
                ),
                SizedBox(height: 190.h),
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
                        MaterialPageRoute(builder: (context) => DistancePage()),
                        (route) => false,
                      );
                    }
                  },
                  child: Builder(
                    builder: (context) {
                      if (isLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return LoginBotton(way: '로그인');
                      }
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => UserJoinPage()),
                    (route) => false,
                  ),
                  child: Text(
                    '아직 가입 안하셨나요?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
