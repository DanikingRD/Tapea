import 'package:flutter/material.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/screen/profile/field/profile_field_builder.dart';

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
      textFieldLabel: 'Link',
      suggestions: const ['Personal Site', 'Google', 'Youtube'],
      field: LinkField(),
      fieldTitlePrefix: _httpsProtocolPrefix,
      onSaved: onSaved,
    );
  }
}
