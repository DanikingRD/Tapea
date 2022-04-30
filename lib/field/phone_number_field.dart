// ignore: implementation_imports
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:tapea/field/profile_field.dart';

class PhoneNumberField extends ProfileField {
  final String? phoneExtension;

  const PhoneNumberField({
    required String title,
    required String subtitle,
    required IconData icon,
    this.phoneExtension,
  }) : super(
          title: title,
          subtitle: subtitle,
          icon: icon,
          type: ProfileFieldType.phoneNumber,
        );
}
