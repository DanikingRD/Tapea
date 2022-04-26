import 'package:flutter/material.dart';
import 'package:tapea/constants.dart';

class BorderlessTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String floatingLabel;
  final bool centerAll;
  final TextInputType? keyboardType;
  final Function(String?)? onChanged;
  const BorderlessTextField({
    Key? key,
    this.controller,
    required this.floatingLabel,
    this.centerAll = false,
    this.keyboardType,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: kRedColor,
      textAlign: centerAll ? TextAlign.center : TextAlign.start,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        floatingLabelBehavior: controller == null || controller!.text.isEmpty
            ? FloatingLabelBehavior.auto
            : FloatingLabelBehavior.always,
        label: centerAll
            ? Center(child: Text(floatingLabel))
            : Text(floatingLabel),
      ),
    );
  }
}
