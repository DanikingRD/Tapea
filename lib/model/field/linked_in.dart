import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/profile_field.dart';

class LinkedInField extends LinkField {
  LinkedInField({
    String title = '',
    String subtitle = '',
    String link = '',
  }) : super(title: title, subtitle: subtitle, link: link);

  @override
  String getUrl(String domain) {
    return 'https://www.linkedin.com/in/' + domain.toLowerCase();
  }

  @override
  IconData get icon => FontAwesomeIcons.linkedinIn;

  @override
  ProfileFieldType get type => ProfileFieldType.linkedIn;

  @override
  String get displayName => 'Linked In';
}
