import 'package:flutter/widgets.dart';
import 'package:tapea/model/field/telegram_field.dart';
import 'package:tapea/screen/profile/components/field/builder/profile_field_builder.dart';

class TelegramFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;
  const TelegramFieldScreen({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      textFieldLabel: 'Username',
      suggestions: const ['Connect with me on Telegram'],
      field: TelegramField(),
      onSaved: onSaved,
    );
  }
}
