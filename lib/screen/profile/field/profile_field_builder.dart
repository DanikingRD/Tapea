import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/widget/borderless_text_field.dart';
import 'package:tapea/widget/circle_icon.dart';

class ProfileFieldScreenBuilder extends StatelessWidget {
  final String title;
  final Widget fieldTitle;
  final List<Widget> content;
  final bool withSuggestions;
  final bool withLabel;
  final Widget? suggestionTitle;
  final Widget? suggestions;
  final Widget? subtitle;
  final TextEditingController? labelController;
  final Function(ProfileNotifier notifier) save;

  const ProfileFieldScreenBuilder({
    Key? key,
    required this.title,
    required this.fieldTitle,
    required this.content,
    this.withSuggestions = true,
    this.withLabel = true,
    this.suggestionTitle = const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'Here are some suggestions for your label:',
        style: TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    ),
    this.suggestions,
    this.labelController,
    this.subtitle,
    required this.save,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const EdgeInsets globalPadding = EdgeInsets.symmetric(horizontal: 20);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              save(context.read<ProfileNotifier>());
              Navigator.pop(context);
            },
            child: const Text(
              'SAVE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          const Divider(
            thickness: 6.0,
            color: kFieldIconScreenDivider,
          ),
          ListTile(
            title: fieldTitle,
            leading: const CircleIcon(
              backgroundColor: kSelectedPageColor,
              iconData: FontAwesomeIcons.phone,
              iconSize: 24,
              circleSize: 48,
            ),
            subtitle: subtitle,
          ),
          const Divider(
            thickness: 6.0,
            color: kFieldIconScreenDivider,
          ),
          ...content,
          if (withLabel) ...{
            Padding(
              padding: globalPadding,
              child: BorderlessTextField(
                controller: labelController,
                floatingLabel: 'Label (optional)',
              ),
            ),
          },
          if (withSuggestions) ...{
            const SizedBox(
              height: 20,
            ),
            if (suggestionTitle != null) suggestionTitle!,
            const SizedBox(
              height: 10,
            ),
            if (suggestions != null) ...{
              Padding(
                padding: globalPadding,
                child: suggestions!,
              )
            }
          }
        ],
      ),
    );
  }
}
