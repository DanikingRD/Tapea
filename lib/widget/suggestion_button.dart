import 'package:flutter/material.dart';
import 'package:tapea/constants.dart';

class SuggestionButton extends StatelessWidget {
  final String suggestion;
  final VoidCallback onPressed;
  const SuggestionButton({
    Key? key,
    required this.suggestion,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(
          suggestion,
          style: const TextStyle(
            color: kRedColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: OutlinedButton.styleFrom(
          primary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
