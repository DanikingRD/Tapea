import 'package:flutter/widgets.dart';
import 'package:tapea/model/field/tiktok_field.dart';
import 'package:tapea/screen/profile/field/builder/profile_field_builder.dart';

class TiktokFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;
  const TiktokFieldScreen({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      textFieldLabel: 'Username',
      suggestions: const ['Follow me on Tiktok'],
      field: TikTokField(),
      onSaved: onSaved,
    );
  }
}
