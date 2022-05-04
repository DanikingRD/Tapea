import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/screen/profile/field/profile_field_builder.dart';
import 'package:tapea/util/util.dart';

class LinkFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;
  static const String _httpsProtocolPrefix = 'https://';

  const LinkFieldScreen({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      title: 'Add Link',
      fieldIcon: FontAwesomeIcons.link,
      textFieldLabel: 'Link',
      suggestions: const ['Personal Site', 'Google', 'Youtube'],
      fieldTitlePrefix: _httpsProtocolPrefix,
      save: (String? fieldTitle, String labelText, ProfileNotifier notifier) {
        save(_httpsProtocolPrefix + fieldTitle!, labelText, notifier, context);
      },
    );
  }

  void save(
    String fieldTitle,
    String labelText,
    ProfileNotifier notifier,
    BuildContext context,
  ) {
    if (fieldTitle.isEmpty) {
      notify(msg: getErrorMessage(), context: context);
    } else {
      notifier.profile.fields.add(
        LinkField(title: fieldTitle, subtitle: labelText),
      );
      onSaved();
      Navigator.pop(context);
    }
  }

  String getErrorMessage() {
    return 'Enter a valid URL to save this field to your card.';
  }
}
