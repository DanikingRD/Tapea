import 'package:flutter/material.dart';
import 'package:tapea/constants.dart';

class BorderlessTextField extends StatelessWidget {
  final TextEditingController controller;
  final String floatingLabel;
  final bool centerAll;

  const BorderlessTextField({
    Key? key,
    required this.controller,
    required this.floatingLabel,
    this.centerAll = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: kRedColor,
      textAlign: centerAll ? TextAlign.center : TextAlign.start,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        floatingLabelBehavior: controller.text.isEmpty
            ? FloatingLabelBehavior.auto
            : FloatingLabelBehavior.always,
        label: centerAll
            ? Center(child: Text(floatingLabel))
            : Text(floatingLabel),
      ),
    );
  }
}
