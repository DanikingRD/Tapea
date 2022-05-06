import 'package:flutter/src/widgets/icon_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/routes.dart';

class FacebookField extends LinkField {
  FacebookField({
    String title = '',
    String subtitle = '',
    String link = '',
  }) : super(title: title, subtitle: subtitle, link: link);
  @override
  String get displayName => 'Facebook';

  @override
  String getUrl(String domain) {
    return 'https://www.facebook.com/' + domain.toLowerCase();
  }

  @override
  IconData get icon => FontAwesomeIcons.facebook;

  @override
  String get route => Routes.facebookField;

  @override
  ProfileFieldType get type => ProfileFieldType.facebook;
}
