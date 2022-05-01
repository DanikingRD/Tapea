import 'package:flutter/material.dart';
import 'package:tapea/constants.dart';

class BorderlessTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String floatingLabel;
  final bool centerAll;
  final TextInputType? keyboardType;
  final Function(String?)? onChanged;
  final String? initialValue;
  const BorderlessTextField({
    Key? key,
    this.controller,
    required this.floatingLabel,
    this.centerAll = false,
    this.keyboardType,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      cursorColor: kRedColor,
      textAlign: centerAll ? TextAlign.center : TextAlign.start,
      keyboardType: keyboardType,
      onChanged: (String text) {
        if (onChanged != null) {
          onChanged!(text);
        }
      },
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
