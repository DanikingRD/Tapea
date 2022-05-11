import 'package:flutter/material.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/util/responsive.dart';

class RecoverAccountLabel extends StatelessWidget {
  const RecoverAccountLabel({Key? key}) : super(key: key);

  void openScreen(BuildContext context, String route) {
    Navigator.pushReplacementNamed(context, Routes.signUp);
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktopScreen(context)
        ? Row(
            children: [
              const Text(
                'Forgot your Password?',
                style: TextStyle(color: kRedColor, fontWeight: FontWeight.bold),
              ),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () => openScreen(context, Routes.signUp),
                child: const Text(
                  'Not a member yet? ',
                  style: TextStyle(
                    color: kRedColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Forgot your password? '),
                  Text(
                    'Get help',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not a member yet? '),
                  GestureDetector(
                    onTap: () => openScreen(context, Routes.signUp),
                    child: Text(
                      'Sign up',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  )
                ],
              ),
            ],
          );
  }
}
