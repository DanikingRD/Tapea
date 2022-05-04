import 'package:flutter/material.dart';
import 'package:tapea/model/field/email_field.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/screen/profile/field/profile_field_builder.dart';
import 'package:tapea/util/util.dart';

class EmailFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;

  const EmailFieldScreen({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      title: 'Add Email',
      fieldIcon: Icons.email,
      textFieldLabel: 'Email',
      suggestions: const [
        'Work',
        'Personal',
      ],
      save: (String? titleText, String labelText, ProfileNotifier notifier) {
        if (titleText!.isEmpty) {
          notify(
            msg: 'Enter your email if you want to save this field',
            context: context,
          );
        } else {
          notifier.profile.fields.add(
            EmailField(
              title: titleText,
              subtitle: labelText,
            ),
          );
          onSaved();
          Navigator.pop(context);
        }
      },
    );
  }
}
