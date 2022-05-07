import 'package:flutter/material.dart';

class ExplanationBox extends StatelessWidget {
  final String explanation;
  final IconData? icon;
  const ExplanationBox({
    Key? key,
    required this.explanation,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Card(
          color: Colors.grey.shade200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                explanation,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (icon != null) ...{
                Icon(icon),
              }
            ],
          ),
        ),
      ),
    );
  }
}
