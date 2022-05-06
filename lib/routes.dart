import 'package:flutter/widgets.dart';
import 'package:tapea/model/field/company_website_field.dart';
import 'package:tapea/model/field/facebook_field.dart';
import 'package:tapea/model/field/instagram_field.dart';
import 'package:tapea/model/field/linked_in.dart';
import 'package:tapea/model/field/telegram_field.dart';
import 'package:tapea/model/field/tiktok_field.dart';
import 'package:tapea/model/field/twitch_field.dart';
import 'package:tapea/screen/auth/login_screen.dart';
import 'package:tapea/screen/auth/sign_up_screen.dart';
import 'package:tapea/screen/auth/verification_screen.dart';
import 'package:tapea/screen/auth/profile_setup.dart';
import 'package:tapea/screen/home_screen.dart';
import 'package:tapea/screen/profile/field/company_website_field_screen.dart';
import 'package:tapea/screen/profile/field/discord_field_screen.dart';
import 'package:tapea/screen/profile/field/email_field_screen.dart';
import 'package:tapea/screen/profile/field/facebook_field_screen.dart';
import 'package:tapea/screen/profile/field/instagram_field_screen.dart';
import 'package:tapea/screen/profile/field/link_field_screen.dart';
import 'package:tapea/screen/profile/field/linked_in_field_screen.dart';
import 'package:tapea/screen/profile/field/location_field.screen.dart';
import 'package:tapea/screen/profile/field/paypal_field_screen.dart';
import 'package:tapea/screen/profile/field/phone_number_field_screen.dart';
import 'package:tapea/screen/profile/editor/profile_editor_screen.dart';
import 'package:tapea/screen/profile/field/tiktok_field_screen.dart';
import 'package:tapea/screen/profile/field/twitch_field_screen.dart';
import 'package:tapea/screen/profile/field/twitter_field_screen.dart';
import 'package:tapea/screen/profile/field/whatsapp_field_screen.dart';
import 'package:tapea/screen/profile/field/youtube_field_screen.dart';
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
