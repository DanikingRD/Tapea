import 'package:flutter/cupertino.dart';
import 'package:tapea/model/field/twitter_field.dart';
import 'package:tapea/screen/profile/field/builder/profile_field_builder.dart';

class TwitterFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;
  const TwitterFieldScreen({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      textFieldLabel: 'Username',
      suggestions: const ['Follow me on Twitter'],
      field: TwitterField(),
      onSaved: onSaved,
    );
  }
}
