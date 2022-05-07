import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final Icon icon;
  final Color? circleColor;
  final Function()? onPressed;
  final double elevation;
  final Object? heroTag;
  const CircleIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.circleColor,
    this.elevation = 3.0,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      child: icon,
      onPressed: onPressed,
      backgroundColor: circleColor,
      elevation: elevation,
      focusElevation: 0.0,
      highlightElevation: 0.0,
    );
  }
}
