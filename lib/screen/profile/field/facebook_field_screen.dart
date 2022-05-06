import 'package:flutter/widgets.dart';
import 'package:tapea/model/field/facebook_field.dart';
import 'package:tapea/screen/profile/field/builder/profile_field_builder.dart';

class FacebookFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;
  const FacebookFieldScreen({Key? key, required this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      textFieldLabel: 'Username',
      suggestions: const ['Add me on Facebook'],
      field: FacebookField(),
      onSaved: onSaved,
    );
  }
}
