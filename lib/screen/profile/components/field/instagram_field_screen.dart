import 'package:flutter/cupertino.dart';
import 'package:tapea/model/field/instagram_field.dart';
import 'package:tapea/screen/profile/components/field/builder/profile_field_builder.dart';

class InstagramFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;
  const InstagramFieldScreen({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      textFieldLabel: 'Username',
      suggestions: const ['Follow me on Instagram'],
      field: InstagramField(),
      onSaved: onSaved,
    );
  }
}
