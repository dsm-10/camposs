import 'package:camposs/component/util.dart';
import 'package:camposs/view/distance_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../component/login_botton.dart';
import '../component/text_field.dart';
import '../component/title.dart';

class UserJoinPage extends StatefulWidget {
  const UserJoinPage({super.key});

  @override
  State<UserJoinPage> createState() => _UserJoinPageState();
}

class _UserJoinPageState extends State<UserJoinPage> {
  late final TextEditingController nicknameController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nicknameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nicknameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<String> _registerUser({
      required String nickname,
      required String password,
    }) async {
      Dio dio = Dio();

      try {
        final response = await dio.post(
          '${ConstValues.BaseURL}/auth/register',
          data: {'nickname': nickname, 'password': password},
        );
        return response.data['token!'];
      } catch (err) {
        print('이미 있는 아이디입니다');
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
              SizedBox(height: 41.h),
              TextsField(
                textEditingController: passwordController,
                hintText: '비밀번호를 입력하세요.',
                obsText: true,
                suffixIcon: Icon(Icons.visibility_off_outlined),
                errorText: '다시 확인해주세요',
              ),
              SizedBox(height: 208.h),
              GestureDetector(
                onTap: () async {
                  final String token = await _registerUser(
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
                child: LoginBotton(way: '회원가입'),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
