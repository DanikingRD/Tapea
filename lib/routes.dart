import 'package:flutter/widgets.dart';
import 'package:tapea/screen/auth/login_screen.dart';
import 'package:tapea/screen/auth/sign_up_screen.dart';
import 'package:tapea/screen/auth/verification_screen.dart';
import 'package:tapea/screen/auth/profile_setup.dart';
import 'package:tapea/screen/home_screen.dart';
import 'package:tapea/screen/profile/phone_number_field.dart';
import 'package:tapea/screen/profile/profile_editor_screen.dart';
import 'package:tapea/screen/welcome_screen.dart';
import 'package:tapea/util/transition.dart';

class Routes {
  static const String welcome = '/welcome';
  static const String signUp = '/sign_up';
  static const String login = '/log_in';
  static const String verification = '/verification';
  static const String profileSetup = '/profile_setup';
  static const String home = '/home';
  static const String profileEditor = '/profile_editor';
  static const String addPhoneField = '/add_phone_field';

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
      case profileSetup:
        return bottomToTop(screen: const ProfileSetup(), settings: settings);
      case home:
        return fade(
          screen: const HomeScreen(),
          settings: settings,
        );
      case profileEditor:
        final bool edit = settings.arguments as bool;
        return bottomToTop(
          screen: ProfileEditorScreen(
            edit: edit,
          ),
          settings: settings,
        );
      case addPhoneField:
        return rightToLeft(
          screen: const PhoneNumberScreen(),
          settings: settings,
        );
      default:
        throw ('Tried to access an unregistered named route');
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

  static Transition rightToLeft({
    required Widget screen,
    required RouteSettings settings,
  }) {
    return Transition(
      builder: ((_) => screen),
      transitionEffect: TransitionEffect.rightToLeft,
      settings: settings,
    );
  }
}
