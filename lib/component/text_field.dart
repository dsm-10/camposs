import 'package:flutter/material.dart';

class TextsField extends StatelessWidget {
  const TextsField({super.key,required this.hintText,required this.obsText,required this.suffixIcon,required this.errorText});
final String hintText;
final bool obsText;
final Widget? suffixIcon;
final String errorText;
  @override
  Widget build(BuildContext context) {
    final baseboder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Color(0xffBBBAB5)),
    );
    return TextFormField(
      obscureText: obsText,
        decoration: InputDecoration(
          hintText: hintText,
          border: baseboder,
            fillColor: Color(0xffBBBAB5),
          filled: true,
          suffixIcon: suffixIcon,
         errorText: errorText,
        ),
      textInputAction: TextInputAction.search,
    );
  }
}
