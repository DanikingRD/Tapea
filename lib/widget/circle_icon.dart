import 'package:flutter/material.dart';
import 'package:tapea/constants.dart';

class CircleIconButton extends StatelessWidget {
  final Icon icon;
  final Color? circleColor;
  final Function()? onPressed;

  const CircleIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.circleColor = kSelectedPageColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: icon,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        primary: kSelectedPageColor, // <-- Button color
      ),
    );
  }
}

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
