import 'package:flutter/material.dart';
import 'package:tapea/model/field/profile_field.dart';

class LinkField extends ProfileField {
  LinkField({
    required String title,
    required String subtitle,
  }) : super(
          title: title,
          subtitle: subtitle,
          icon: Icons.link,
          type: ProfileFieldType.link,
          floatingLabel: 'Link',
        );
}
