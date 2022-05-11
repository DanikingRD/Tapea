import 'package:flutter/material.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/util/responsive.dart';

class SignUpLabel extends StatelessWidget {
  const SignUpLabel({Key? key}) : super(key: key);

  void openLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (Responsive.isDesktopScreen(context)) ...{
          GestureDetector(
            onTap: () => openLogin(context),
            child: const Text(
              'Have an account?',
              style: TextStyle(
                color: kRedColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        } else ...{
          const Text(
            'Have an account? ',
          ),
          GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, Routes.login),
            child: Text(
              'Log in',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        }
      ],
    );
  }
}
