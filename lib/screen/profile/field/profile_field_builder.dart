import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/widget/borderless_text_field.dart';
import 'package:tapea/widget/circle_icon.dart';
import 'package:tapea/widget/notification_box.dart';
import 'package:tapea/widget/suggestion_button.dart';

class ProfileFieldScreenBuilder extends StatefulWidget {
  final String title;
  final IconData fieldIcon;
  final Widget? fieldTitle;
  final String textFieldLabel;
  final List<Widget>? content;
  final bool withSuggestions;
  final bool withLabel;
  final Widget? suggestionTitle;
  final Function(String labelText, ProfileNotifier notifier) save;
  final List<String>? suggestions;
  final bool isPhoneNumberField;
  final String? filterMessage;
  final bool Function()? customFilter;
  const ProfileFieldScreenBuilder({
    Key? key,
    required this.title,
    required this.fieldIcon,
    this.fieldTitle,
    required this.textFieldLabel,
    this.content,
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
    required this.save,
    this.isPhoneNumberField = false,
    this.filterMessage,
    this.customFilter,
  }) : super(key: key);

  @override
  State<ProfileFieldScreenBuilder> createState() =>
      ProfileFieldScreenBuilderState();
}

class ProfileFieldScreenBuilderState extends State<ProfileFieldScreenBuilder> {
  late final TextEditingController? _titleController;
  final TextEditingController _labelController = TextEditingController();

  @override
  void initState() {
    // Don't initialize if this is a phone number field
    if (!widget.isPhoneNumberField) {
      _titleController = TextEditingController();
    } else {
      _titleController = null;
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_titleController != null) {
      _titleController!.dispose();
    }
    _labelController.dispose();
    super.dispose();
  }

  bool saveFilter() {
    if (_titleController != null) {
      if (_titleController!.text.isEmpty) {
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              // If this method was triggered, the filter message shouldn't be null
              return NotificationBox(msg: widget.filterMessage!);
            });
        return true; // Filter was accessed
      }
    }
    return false; // We can save changes
  }

  void saveField() {
    if (_titleController == null) {
      if (!widget.customFilter!()) {
        widget.save(_labelController.text, context.read<ProfileNotifier>());
      }
    } else {
      if (!saveFilter()) {
        widget.save(_labelController.text, context.read<ProfileNotifier>());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const EdgeInsets globalPadding = EdgeInsets.symmetric(horizontal: 20);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: saveField,
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
      body: AnimatedBuilder(
        builder: ((context, child) {
          return ListView(
            children: [
              const Divider(
                thickness: 6.0,
                color: kFieldIconScreenDivider,
              ),
              ListTile(
                title: widget.fieldTitle ??
                    Text(
                      // If we don't provide a field title
                      // then this is not a phone number fied
                      // therefore we can assume the title controller
                      // will be initialied.
                      _titleController!.text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                leading: CircleIcon(
                  backgroundColor: kSelectedPageColor,
                  iconData: widget.fieldIcon,
                  iconSize: 24,
                  circleSize: 48,
                ),
                subtitle: getSubtitle(),
              ),
              const Divider(
                thickness: 6.0,
                color: kFieldIconScreenDivider,
              ),
              if (!widget.isPhoneNumberField) ...{
                Padding(
                  padding: globalPadding,
                  child: BorderlessTextField(
                    controller: _titleController,
                    floatingLabel: widget.textFieldLabel,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              },
              if (widget.content != null) ...widget.content!,
              if (widget.withLabel) ...{
                Padding(
                  padding: globalPadding,
                  child: BorderlessTextField(
                    controller: _labelController,
                    floatingLabel: 'Label (optional)',
                  ),
                ),
              },
              if (widget.withSuggestions) ...{
                const SizedBox(
                  height: 20,
                ),
                if (widget.suggestionTitle != null) widget.suggestionTitle!,
                const SizedBox(
                  height: 10,
                ),
                if (widget.suggestions != null) ...{
                  if (widget.suggestions!.length <= 4) ...{
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          ...getSuggestions(),
                        ],
                      ),
                    )
                  }
                }
              }
            ],
          );
        }),
        animation: Listenable.merge([
          if (_titleController != null) ...{
            _titleController,
          },
          _labelController,
        ]),
      ),
    );
  }

  List<Widget> getSuggestions() {
    final List<SuggestionButton> buttons = [];
    for (int i = 0; i < widget.suggestions!.length; i++) {
      final String text = widget.suggestions![i];
      buttons.add(
        SuggestionButton(
          suggestion: text,
          onPressed: () {
            _labelController.text = text;
          },
        ),
      );
    }
    return buttons;
  }

  Widget? getSubtitle() {
    return _labelController.text.isEmpty
        ? null
        : Text(
            _labelController.text,
          );
  }
}
