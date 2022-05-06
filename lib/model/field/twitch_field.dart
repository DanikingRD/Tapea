import 'package:flutter/src/widgets/icon_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/routes.dart';

class TwitchField extends LinkField {
  TwitchField({
    String title = '',
    String subtitle = '',
    String link = '',
  }) : super(
          title: title,
          subtitle: subtitle,
          link: link,
        );
  @override
  String get displayName => 'Twitch';

  @override
  String getUrl(String domain) {
    return 'https://twitch.tv/' + domain.toLowerCase();
  }

  @override
  IconData get icon => FontAwesomeIcons.twitch;

  @override
  String get route => Routes.twitchField;

  @override
  ProfileFieldType get type => ProfileFieldType.twitch;
}
