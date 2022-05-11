import 'package:flutter/material.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/util/responsive.dart';
import 'package:tapea/widget/loading_indicator.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool loading;
  const AuthButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: kRedColor,
        minimumSize: const Size(double.infinity, 40),
      ),
      onPressed: onTap,
      child: loading ? const LoadingIndicator() : getText(context),
    );
  }

  Widget getText(BuildContext context) {
    if (Responsive.isMobileScreen(context)) return Text(text);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
      ),
    );
  }
}
