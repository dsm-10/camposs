import 'package:flutter/material.dart';

class TextsField extends StatelessWidget {
  const TextsField({
    super.key,
    required this.hintText,
    required this.obsText,
    required this.suffixIcon,
    required this.errorText,
    required this.textEditingController,
  });

  final String hintText;
  final bool obsText;
  final Widget? suffixIcon;
  final String errorText;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    final baseboder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Color(0xffBBBAB5)),
    );
    return TextFormField(
      controller: textEditingController,
      obscureText: obsText,
      style: TextStyle(fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontWeight: FontWeight.w400),
        border: baseboder,
        fillColor: Color(0xffBBBAB5),
        filled: true,
        suffixIcon: suffixIcon,
        errorText: null,
        suffixStyle: TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }
}
