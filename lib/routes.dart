import 'package:flutter/widgets.dart';
import 'package:tapea/screen/home_screen.dart';
import 'package:tapea/screen/login_screen.dart';
import 'package:tapea/screen/sign_up_screen.dart';
import 'package:tapea/screen/verification_screen.dart';
import 'package:tapea/screen/welcome_screen.dart';
import 'package:tapea/util/transition.dart';

class Routes {
  static const String welcome = '/welcome';
  static const String signUp = '/sign_up';
  static const String login = '/log_in';
  static const String verification = '/verification';
  static const String home = '/home';

  static Route<dynamic> build(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case '/welcome':
        return fade(screen: const WelcomeScreen(), settings: settings);
      case signUp:
        return bottomToTop(
          screen: const SignUpScreen(),
          settings: settings,
        );
      case login:
        return bottomToTop(
          screen: const LoginScreen(),
          settings: settings,
        );
      case verification:
        return bottomToTop(
          screen: const VerificationScreen(),
          settings: settings,
        );
      case home:
        return fade(
          screen: const HomeScreen(),
          settings: settings,
        );
      default:
        throw ('Tried to access an unregistered named screen');
    }
  }

  static Transition bottomToTop({
    required Widget screen,
    required RouteSettings settings,
  }) {
    return Transition(
      builder: ((_) => screen),
      transitionEffect: TransitionEffect.bottomToTop,
      settings: settings,
    );
  }

  static Transition fade({
    required Widget screen,
    required RouteSettings settings,
  }) {
    return Transition(
      builder: ((_) => screen),
      transitionEffect: TransitionEffect.fade,
      settings: settings,
    );
  }
}
