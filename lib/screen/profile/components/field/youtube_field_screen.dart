import 'package:flutter/widgets.dart';
import 'package:tapea/model/field/youtube_field.dart';
import 'package:tapea/screen/profile/components/field/builder/profile_field_builder.dart';

class YoutubeFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;
  const YoutubeFieldScreen({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      textFieldLabel: 'Channel',
      suggestions: const ['Subscribe'],
      field: YoutubeField(),
      onSaved: onSaved,
    );
  }
}
