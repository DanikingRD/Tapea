import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tapea/constants.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final bool hiddenText;

  const AuthTextField({
    Key? key,
    required this.controller,
    this.inputType = TextInputType.emailAddress,
    this.hiddenText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: hiddenText,
      keyboardType: inputType,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kRedColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
