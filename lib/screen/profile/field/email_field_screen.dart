import 'package:flutter/material.dart';
import 'package:tapea/model/field/email_field.dart';
import 'package:tapea/screen/profile/field/builder/profile_field_builder.dart';

class EmailFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;

  const EmailFieldScreen({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      textFieldLabel: 'Email',
      suggestions: const [
        'Work',
        'Personal',
      ],
      field: EmailField(),
      titleKeyboard: TextInputType.emailAddress,
      onSaved: onSaved,
    );
  }
}
