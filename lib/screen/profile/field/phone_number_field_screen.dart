import 'package:flutter/material.dart';
import 'package:tapea/model/field/phone_number_field.dart';
import 'package:tapea/screen/profile/field/profile_field_builder.dart';

class PhoneNumberFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;
  const PhoneNumberFieldScreen({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      title: 'Add Phone Number',
      textFieldLabel: 'Phone Number',
      suggestions: const ['Home', 'Mobile', 'Work', 'Cell'],
      field: PhoneNumberField(),
      onSaved: onSaved,
    );
  }
}
