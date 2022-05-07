import 'package:flutter/material.dart';
import 'package:tapea/model/field/link_field_impl.dart';
import 'package:tapea/screen/profile/components/field/builder/profile_field_builder.dart';

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
      textFieldLabel: 'Link',
      suggestions: const ['Personal Site', 'Google', 'Youtube'],
      field: LinkFieldImpl(),
      fieldTitlePrefix: _httpsProtocolPrefix,
      onSaved: onSaved,
    );
  }
}
