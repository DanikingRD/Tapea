import 'package:flutter/src/widgets/icon_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/routes.dart';

class YoutubeField extends LinkField {
  YoutubeField({
    String title = '',
    String subtitle = '',
    String link = '',
  }) : super(title: title, subtitle: subtitle, link: link);
  @override
  String get displayName => 'Youtube';

  @override
  String getUrl(String domain) {
    return 'https://www.youtube.com/c/' + domain.toLowerCase();
  }

  @override
  IconData get icon => FontAwesomeIcons.youtube;

  @override
  String get route => Routes.youtubeField;

  @override
  ProfileFieldType get type => ProfileFieldType.youtube;
}
