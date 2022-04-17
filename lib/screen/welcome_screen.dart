import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tapea/constants.dart';
import 'package:flutter/services.dart';
import 'package:tapea/routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    const SizedBox margin = SizedBox(
      height: 50,
    );
    const Color textColor = Colors.white;
    // return AnnotatedRegion<SystemUiOverlayStyle>(
    //   value: const SystemUiOverlayStyle(
    //     statusBarIconBrightness: Brightness.dark,
    //     statusBarColor: Colors.transparent,
    //   ),
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 99, 99),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              children: [
                margin,
                Image.asset(
                  'assets/icons/tap.png',
                  height: 128,
                  color: textColor,
                ),
                margin,
                Text(
                  'Welcome to Tapea.',
                  style: theme.textTheme.headline6!
                      .copyWith(fontWeight: FontWeight.bold, color: textColor),
                ),
                margin,
                Text(
                  'With a tap of your device or scan of your QR code, share your info with anyone you meet',
                  style: theme.textTheme.headline6!.copyWith(color: textColor),
                ),
                margin,
                Text(
                  'Let\'s get your new Tapea digital business card set up',
                  style: theme.textTheme.headline6!.copyWith(color: textColor),
                ),
                margin,
                FittedBox(
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, Routes.signUp),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 26,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: textColor,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              'GET STARTED',
                              style: theme.textTheme.button!.copyWith(
                                color: kRedColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: kRedColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                margin,
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routes.login),
                  child: Text(
                    'LOG IN WITH EXISTING ACCOUNT',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: textColor,
                    ),
                  ),
                ),
                Flexible(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
