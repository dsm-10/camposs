import 'package:flutter/material.dart' hide Title;
import '../component/login_botton.dart';
import '../component/text_field.dart';
import '../component/title.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){FocusScope.of(context).unfocus();},
      child: Scaffold(
        backgroundColor: Color(0xff1E1E1E),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 41),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 213,),
              Titles(),
              SizedBox(height: 86,),
              TextsField(hintText: '아이디를 입력하세요.', obsText: false, suffixIcon: null, errorText: '',),
              SizedBox(height: 41,),
              TextsField(hintText: '비밀번호를 입력하세요.', obsText: true, suffixIcon: Icon(Icons.visibility_off_outlined), errorText: '다시 확인해주세요',),
              SizedBox(height: 208,),
              LoginBotton(way: '로그인',),
            ],
          ),
        ),
      ),
    );
  }
}