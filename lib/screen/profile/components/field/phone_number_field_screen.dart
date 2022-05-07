import 'package:flutter/material.dart';
import 'package:tapea/model/field/phone_number_field.dart';
import 'package:tapea/model/field/phone_number_field_impl.dart';
import 'package:tapea/screen/profile/components/field/builder/profile_field_builder.dart';

class PhoneNumberFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;
  const PhoneNumberFieldScreen({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      textFieldLabel: 'Phone Number',
      suggestions: const ['Home', 'Mobile', 'Work', 'Cell'],
      field: PhoneNumberFieldImpl(),
      onSaved: onSaved,
    );
  }
}
