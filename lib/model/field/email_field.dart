import 'package:flutter/material.dart';
import 'package:tapea/model/field/profile_field.dart';

class EmailField extends ProfileField {
  EmailField({
    required String title,
    required String subtitle,
  }) : super(
          title: title,
          subtitle: subtitle,
          icon: Icons.email,
          type: ProfileFieldType.email,
          floatingLabel: 'Email',
        );
}
