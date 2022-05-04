import 'package:flutter/material.dart';
import 'package:tapea/model/field/profile_field.dart';

class EmailField extends ProfileField {
  EmailField({
    String title = '',
    String subtitle = '',
  }) : super(
          title: title,
          subtitle: subtitle,
          icon: Icons.email,
          type: ProfileFieldType.email,
        );

  @override
  String get displayName => 'Email';
}
