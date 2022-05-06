import 'package:flutter/src/widgets/icon_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/routes.dart';

class TikTokField extends LinkField {
  TikTokField({
    String title = '',
    String subtitle = '',
    String link = '',
  }) : super(title: title, subtitle: subtitle, link: link);
  @override
  String get displayName => 'Tiktok';

  @override
  String getUrl(String domain) {
    return 'https://www.tiktok.com/@' + domain.toLowerCase();
  }

  @override
  IconData get icon => FontAwesomeIcons.tiktok;

  @override
  String get route => Routes.tiktokField;

  @override
  ProfileFieldType get type => ProfileFieldType.tiktok;
}
