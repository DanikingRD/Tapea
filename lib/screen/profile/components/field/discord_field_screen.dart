import 'package:flutter/widgets.dart';
import 'package:tapea/model/field/discord_field.dart';
import 'package:tapea/screen/profile/components/field/builder/profile_field_builder.dart';

class DiscordFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;
  const DiscordFieldScreen({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      textFieldLabel: 'Server',
      suggestions: const ['Join to our Discord server'],
      field: DiscordField(),
      onSaved: onSaved,
    );
  }
}
