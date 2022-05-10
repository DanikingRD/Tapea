import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionHeader extends StatelessWidget {
  final String title;
  final IconData? icon;

  const OptionHeader({
    Key? key,
    required this.title,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        if (icon != null) ...{
          Icon(icon),
        },
        Text(
          title,
          style: Theme.of(context).textTheme.headline6!.copyWith(),
        ),
      ],
    );
  }
}
