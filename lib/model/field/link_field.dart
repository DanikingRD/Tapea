import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/profile_field.dart';

class LinkField extends ProfileField {
  LinkField({
    String title = '',
    String subtitle = '',
  }) : super(
          title: title,
          subtitle: subtitle,
          icon: FontAwesomeIcons.link,
          type: ProfileFieldType.link,
        );

  @override
  String get displayName => 'Link';
}
