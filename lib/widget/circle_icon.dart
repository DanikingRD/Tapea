import 'package:flutter/material.dart';
import 'package:tapea/constants.dart';

class CircleIconButton extends StatelessWidget {
  final Icon icon;
  final Color? circleColor;
  final Function()? onPressed;
  final double elevation;
  const CircleIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.circleColor = kSelectedPageColor,
    this.elevation = 3.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: icon,
      onPressed: onPressed,
      backgroundColor: kSelectedPageColor,
      elevation: elevation,
      focusElevation: 0.0,
      highlightElevation: 0.0,
    );
  }
}
