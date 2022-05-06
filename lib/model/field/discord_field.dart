import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/routes.dart';

class DiscordField extends LinkField {
  DiscordField({
    String title = '',
    String subtitle = '',
    String link = '',
  }) : super(title: title, subtitle: subtitle, link: link);

  @override
  String get displayName => 'Discord';

  @override
  String getUrl(String domain) {
    return 'https://discord.gg/' + domain.toLowerCase();
  }

  @override
  IconData get icon => Icons.discord;

  @override
  String get route => Routes.discordField;

  @override
  ProfileFieldType get type => ProfileFieldType.discord;
}
