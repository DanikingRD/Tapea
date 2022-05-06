import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/routes.dart';

class InstagramField extends LinkField {
  InstagramField({
    String title = '',
    String subtitle = '',
    String link = '',
  }) : super(title: title, subtitle: subtitle, link: link);

  @override
  ProfileFieldType get type => ProfileFieldType.instagram;
  @override
  String get route => Routes.instagramField;

  @override
  IconData get icon => FontAwesomeIcons.instagram;

  @override
  String get displayName => 'Instagram';

  @override
  String getUrl(String domain) {
    return 'https://instagram.com/' + domain;
  }
}
