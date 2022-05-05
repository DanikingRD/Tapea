import 'package:flutter/src/widgets/icon_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/profile_field.dart';

class LinkField extends ProfileField {
  String link;
  LinkField({
    String title = '',
    String subtitle = '',
    this.link = '',
  }) : super(
          title: title,
          subtitle: subtitle,
        );

  @override
  String get displayName => 'Link';

  String getUrl(String domain) {
    return 'https://www.' + domain.toLowerCase() + '.com';
  }

  void setLink(String link) {
    this.link = link;
  }

  @override
  IconData get icon => FontAwesomeIcons.link;

  @override
  ProfileFieldType get type => ProfileFieldType.link;
}
