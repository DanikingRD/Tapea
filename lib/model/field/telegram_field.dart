import 'package:flutter/src/widgets/icon_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/routes.dart';

class TelegramField extends LinkField {
  TelegramField({
    String title = '',
    String subtitle = '',
    String link = '',
  }) : super(title: title, subtitle: subtitle, link: link);

  @override
  String get displayName => 'Telegram';

  @override
  String getUrl(String domain) {
    return 'https://telegram.me/' + domain.toLowerCase();
  }

  @override
  IconData get icon => FontAwesomeIcons.telegram;

  @override
  String get route => Routes.telegramField;

  @override
  ProfileFieldType get type => ProfileFieldType.telegram;
}
