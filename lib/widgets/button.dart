import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomButon extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButon({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        alignment: Alignment.center,
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          color: mainYellowColor,
        ),
        child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.black),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
