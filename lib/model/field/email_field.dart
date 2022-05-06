import 'package:flutter/material.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/routes.dart';

class EmailField extends ProfileField {
  EmailField({
    String title = '',
    String subtitle = '',
  }) : super(
          title: title,
          subtitle: subtitle,
        );

  @override
  String get displayName => 'Email';

  @override
  IconData get icon => Icons.email;

  @override
  ProfileFieldType get type => ProfileFieldType.email;

  @override
  String get route => Routes.emailField;
}
