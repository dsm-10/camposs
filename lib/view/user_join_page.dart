import 'package:camposs/component/util.dart';
import 'package:camposs/view/login_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  Future<int> _userJoin({
    required String nickname,
    required String password,
  }) async {
    Dio dio = Dio();

    try {
      final response = await dio.post(
        '${ConstValues.BaseURL}/auth/register',
        data: {'nickname': nickname, 'password': password},
      );

      return response.statusCode!;
    } catch (err) {
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
                  obsText: true,
                  suffixIcon: Icon(Icons.visibility_off_outlined),
                  errorText: '다시 확인해주세요',
                ),
                SizedBox(height: 190.h),
                GestureDetector(
                  onTap: () async {
                    await _userJoin(
                      nickname: nicknameController.text,
                      password: passwordController.text,
                    );

                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      );
                    }
                  },
                  child: LoginBotton(way: '회원가입'),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
                  ),
                  child: Text(
                    '이미 가입 하셨나요?',
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
