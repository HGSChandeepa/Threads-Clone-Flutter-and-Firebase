import 'package:flutter/material.dart';

class TextFeildInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType inputkeyboardType;
  final String hintText;

  const TextFeildInput(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.isPassword,
      required this.inputkeyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //the sytyling for the text feild
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: inputkeyboardType,
      obscureText: isPassword,
    );
  }
}
