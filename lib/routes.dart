import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tapea/screen/auth/default_profile/profile_setup.dart';
import 'package:tapea/screen/auth/login/login_screen.dart';
import 'package:tapea/screen/auth/sign_up/sign_up_screen.dart';
import 'package:tapea/screen/auth/verification_screen.dart';
import 'package:tapea/screen/home_screen.dart';
import 'package:tapea/screen/profile/components/editor/profile_editor_screen.dart';
import 'package:tapea/screen/profile/components/field/phone_number_field_screen.dart';
import 'package:tapea/screen/profile/components/field/company_website_field_screen.dart';
import 'package:tapea/screen/profile/components/field/discord_field_screen.dart';
import 'package:tapea/screen/profile/components/field/email_field_screen.dart';
import 'package:tapea/screen/profile/components/field/facebook_field_screen.dart';
import 'package:tapea/screen/profile/components/field/instagram_field_screen.dart';
import 'package:tapea/screen/profile/components/field/link_field_screen.dart';
import 'package:tapea/screen/profile/components/field/linked_in_field_screen.dart';
import 'package:tapea/screen/profile/components/field/location_field.screen.dart';
import 'package:tapea/screen/profile/components/field/paypal_field_screen.dart';
import 'package:tapea/screen/profile/components/field/tiktok_field_screen.dart';
import 'package:tapea/screen/profile/components/field/twitch_field_screen.dart';
import 'package:tapea/screen/profile/components/field/twitter_field_screen.dart';
import 'package:tapea/screen/profile/components/field/whatsapp_field_screen.dart';
import 'package:tapea/screen/profile/components/field/youtube_field_screen.dart';
import 'package:tapea/screen/profile/components/qr/profile_qr_screen.dart';
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
  static const String phoneNumberField = '/phone_number';
  static const String emailField = '/email';
  static const String linkField = '/link';
  static const String locationField = '/location';
  static const String companyWebsiteField = '/company_website';
  static const String linkedInField = '/linked_in';
  static const String paypalField = '/paypal';
  static const String instagramField = '/instagram';
  static const String twitterField = '/twitter';
  static const String facebookField = '/facebook';
  static const String youtubeField = '/youtube';
  static const String discordField = '/discord';
  static const String telegramField = '/telegram';
  static const String tiktokField = '/tiktok';
  static const String twitchField = '/twitch';
  static const String profileQr = '/profile_qr';

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
        return bottomToTop(
            screen: const ProfileSetupScreen(), settings: settings);
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
      case phoneNumberField:
        final onSaved = settings.arguments as VoidCallback;
        return rightToLeft(
          screen: PhoneNumberFieldScreen(
            onSaved: onSaved,
          ),
          settings: settings,
        );
      case emailField:
        final onSaved = settings.arguments as VoidCallback;
        return rightToLeft(
          screen: EmailFieldScreen(
            onSaved: onSaved,
          ),
          settings: settings,
        );
      case linkField:
        final onSaved = settings.arguments as VoidCallback;
        return rightToLeft(
          screen: LinkFieldScreen(onSaved: onSaved),
          settings: settings,
        );
      case locationField:
        final onSaved = settings.arguments as VoidCallback;
        return rightToLeft(
          screen: LocationFieldScreen(onSaved: onSaved),
          settings: settings,
        );
      case companyWebsiteField:
        final onSaved = settings.arguments as VoidCallback;
        return rightToLeft(
          screen: CompanyWebsiteFieldScreen(onSaved: onSaved),
          settings: settings,
        );
      case linkedInField:
        final onSaved = settings.arguments as VoidCallback;
        return rightToLeft(
          screen: LinkedInFieldScreen(onSaved: onSaved),
          settings: settings,
        );
      case paypalField:
        final onSaved = settings.arguments as VoidCallback;
        return rightToLeft(
          screen: PaypalFieldScreen(onSaved: onSaved),
          settings: settings,
        );
      case instagramField:
        final onSaved = settings.arguments as VoidCallback;
        return rightToLeft(
          screen: InstagramFieldScreen(onSaved: onSaved),
          settings: settings,
        );
      case twitterField:
        final onSaved = settings.arguments as VoidCallback;
        return rightToLeft(
          screen: TwitterFieldScreen(onSaved: onSaved),
          settings: settings,
        );
      case facebookField:
        final onSaved = settings.arguments as VoidCallback;
        return rightToLeft(
          screen: FacebookFieldScreen(onSaved: onSaved),
          settings: settings,
        );
      case youtubeField:
        final onSaved = settings.arguments as VoidCallback;
        return rightToLeft(
          screen: YoutubeFieldScreen(onSaved: onSaved),
          settings: settings,
        );
      case discordField:
        final onSaved = settings.arguments as VoidCallback;
        return rightToLeft(
          screen: DiscordFieldScreen(onSaved: onSaved),
          settings: settings,
        );
      case telegramField:
        final onSaved = settings.arguments as VoidCallback;
        return rightToLeft(
          screen: TelegramFieldScreen(onSaved: onSaved),
          settings: settings,
        );
      case tiktokField:
        final onSaved = settings.arguments as VoidCallback;
        return rightToLeft(
          screen: TiktokFieldScreen(onSaved: onSaved),
          settings: settings,
        );
      case twitchField:
        final onSaved = settings.arguments as VoidCallback;
        return rightToLeft(
          screen: TwitchFieldScreen(onSaved: onSaved),
          settings: settings,
        );
      case profileQr:
        return bottomToTop(
          screen: const ProfileQrScreen(),
          settings: settings,
        );
      default:
        return _errorRoute(settings);
    }
  }

  static Route<dynamic> _errorRoute(RouteSettings settings) {
    return fade(
      screen: Scaffold(
        appBar: AppBar(
          title: const Text('Page not found'),
        ),
      ),
      settings: settings,
    );
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
