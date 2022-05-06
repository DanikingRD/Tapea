import 'package:flutter/widgets.dart';
import 'package:tapea/model/field/twitch_field.dart';
import 'package:tapea/screen/profile/field/builder/profile_field_builder.dart';

class TwitchFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;
  const TwitchFieldScreen({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      textFieldLabel: 'Username',
      suggestions: const ['Follow me on Twitch'],
      field: TwitchField(),
      onSaved: onSaved,
    );
  }
}
