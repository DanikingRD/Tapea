import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionDivider extends StatelessWidget {
  const OptionDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 20,
      thickness: 1,
    );
  }
}
