import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/field/profile_field.dart';

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
