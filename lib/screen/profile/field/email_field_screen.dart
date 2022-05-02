import 'package:flutter/material.dart';
import 'package:tapea/model/field/email_field.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/screen/profile/field/profile_field_builder.dart';
import 'package:tapea/util/util.dart';

class EmailScreenField extends StatefulWidget {
  const EmailScreenField({Key? key}) : super(key: key);

  @override
  State<EmailScreenField> createState() => _EmailScreenFieldState();
}

class _EmailScreenFieldState extends State<EmailScreenField> {
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
      save: save,
    );
  }

  void save(String? titleText, String labelText, ProfileNotifier notifier) {
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
      Navigator.pop(context);
    }
  }
}
