import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/field/phone_number_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/util/util.dart';
import 'package:tapea/widget/borderless_text_field.dart';
import 'package:tapea/widget/circle_icon.dart';
import 'package:tapea/widget/suggestion_button.dart';

class ProfileFieldScreenBuilder extends StatefulWidget {
  final String title;
  final IconData fieldIcon;
  final Widget? fieldTitle;
  final String fieldTitlePrefix;
  final String textFieldLabel;
  final List<Widget>? content;
  final bool withSuggestions;
  final bool withLabel;
  final Widget? suggestionTitle;
  final List<String>? suggestions;
  final bool isPhoneNumberField;
  final ProfileField field;
  final VoidCallback onSaved;
  const ProfileFieldScreenBuilder({
    Key? key,
    required this.title,
    required this.fieldIcon,
    this.fieldTitle,
    this.fieldTitlePrefix = '',
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
    this.isPhoneNumberField = false,
    required this.field,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<ProfileFieldScreenBuilder> createState() =>
      ProfileFieldScreenBuilderState();
}

class ProfileFieldScreenBuilderState extends State<ProfileFieldScreenBuilder> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();
  late final TextEditingController? _phoneExtController;
  late CountryCode _code;
  bool internationalNumber = true;

  @override
  void initState() {
    // initialize if this is  phone number field
    if (widget.field is PhoneNumberField) {
      _phoneExtController = TextEditingController();
      _code = CountryCode.fromJson(codes[61]);
    } else {
      _phoneExtController = null;
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _labelController.dispose();
    if (_phoneExtController != null) {
      _phoneExtController!.dispose();
    }
    super.dispose();
  }

  bool saveField() {
    if (!widget.isPhoneNumberField) {
      if (_titleController.text.isEmpty) {
        notify(msg: widget.field.displayName, context: context);
        return false;
      } else {
        final profile = context.read<ProfileNotifier>().profile;
        widget.field.profileTitle = _titleController.text;
        widget.field.profileSubtitle = _labelController.text;
        profile.fields.add(widget.field);
        return true;
      }
    }
    return false;
  }

  String getErrorMessageFor(String fieldType) {
    return 'Enter your ' +
        fieldType.toLowerCase() +
        ' if you want to save this field to your profile.';
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
            onPressed: () {
              if (saveField()) {
                widget.onSaved();
                Navigator.pop(context);
              }
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
      body: AnimatedBuilder(
        builder: ((context, child) {
          return ListView(
            children: [
              const Divider(
                thickness: 6.0,
                color: kFieldIconScreenDivider,
              ),
              ListTile(
                title: getIconTitle(context),
                leading: CircleIconButton(
                  onPressed: null,
                  elevation: 1.0,
                  icon: Icon(widget.fieldIcon),
                ),
                subtitle: getSubtitle(),
              ),
              const Divider(
                thickness: 6.0,
                color: kFieldIconScreenDivider,
              ),
              getTitleTextField(),
              if (widget.field is PhoneNumberField) ...{
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: getSwitch(),
                    ),
                    Text(
                      'Use international number',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
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
          _titleController,
          _labelController,
        ]),
      ),
    );
  }

  Widget getIconTitle(BuildContext context) {
    return Text(
      widget.fieldTitlePrefix + _titleController.text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
    // final theme = Theme.of(context);
    // if (widget.field is PhoneNumberField) {
    //   if (_phoneExtController!.text.isNotEmpty) {
    //     return Padding(
    //       padding: const EdgeInsets.only(left: 5),
    //       child: Text(
    //         'Ext. ' + _phoneExtController!.text,
    //         style: theme.textTheme.bodyMedium!.copyWith(
    //           color: Colors.grey[600],
    //         ),
    //       ),
    //     );
    //   }
    // } else {
    //   return Text(
    //     widget.fieldTitlePrefix + _titleController.text,
    //     style: const TextStyle(
    //       fontWeight: FontWeight.bold,
    //     ),
    //   );
    // }
  }

  String fullPhoneNumber() {
    return getCode() + _titleController.text;
  }

  String getCode() {
    return internationalNumber ? _code.toString() : '';
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

  Widget getTitleTextField() {
    if (widget.field is PhoneNumberField) {
      return Row(
        children: [
          if (internationalNumber) ...{
            Align(
              alignment: Alignment.topCenter,
              child: CountryCodePicker(
                initialSelection: 'DO',
                favorite: const ['DO', 'US'],
                onChanged: (CountryCode code) {
                  setState(() {
                    _code = code;
                  });
                },
              ),
            ),
          },
          Expanded(
            flex: 2,
            child: BorderlessTextField(
              controller: _titleController,
              floatingLabel: 'Phone Number',
              keyboardType: TextInputType.phone,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: BorderlessTextField(
                controller: _phoneExtController,
                floatingLabel: 'Ext.',
                keyboardType: TextInputType.phone,
              ),
            ),
          ),
        ],
      );
    } else {
      return BorderlessTextField(
        controller: _titleController,
        floatingLabel: widget.textFieldLabel,
        keyboardType: TextInputType.emailAddress,
      );
    }
  }

  Widget getSwitch() {
    return Switch.adaptive(
      value: internationalNumber,
      activeColor: kSelectedPageColor,
      onChanged: (value) {
        setState(() {
          internationalNumber = value;
        });
      },
    );
  }
}
