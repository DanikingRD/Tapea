import 'package:flutter/widgets.dart';
import 'package:tapea/model/field/linked_in.dart';
import 'package:tapea/screen/profile/components/field/builder/profile_field_builder.dart';

class LinkedInFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;

  const LinkedInFieldScreen({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      textFieldLabel: 'Username',
      suggestions: const ['Connect with me on LinkedIn'],
      field: LinkedInField(),
      onSaved: onSaved,
    );
  }
}
