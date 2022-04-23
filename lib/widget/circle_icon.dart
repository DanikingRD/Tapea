import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData iconData;
  final double iconSize;
  final double circleSize;

  const CircleIcon({
    Key? key,
    required this.backgroundColor,
    required this.iconData,
    this.iconSize = 32,
    this.circleSize = 64,
    this.foregroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: circleSize,
      height: circleSize,
      child: ClipOval(
        child: Material(
          color: backgroundColor,
          child: Icon(
            iconData,
            color: foregroundColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
