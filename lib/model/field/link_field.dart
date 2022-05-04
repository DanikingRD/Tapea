import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/profile_field.dart';

class LinkField extends ProfileField {
  LinkField({
    required String title,
    required String subtitle,
  }) : super(
          title: title,
          subtitle: subtitle,
          icon: FontAwesomeIcons.link,
          type: ProfileFieldType.link,
          floatingLabel: 'Link',
        );
}
