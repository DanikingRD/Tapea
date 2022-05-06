import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/routes.dart';

class TwitterField extends LinkField {
  TwitterField({
    String title = '',
    String subtitle = '',
    String link = '',
  }) : super(title: title, subtitle: subtitle, link: link);
  @override
  ProfileFieldType get type => ProfileFieldType.twitter;
  @override
  String get route => Routes.twitterField;

  @override
  IconData get icon => FontAwesomeIcons.twitter;

  @override
  String get displayName => 'Twitter';

  @override
  String getUrl(String domain) {
    return 'https://twitter.com/' + domain;
  }
}
