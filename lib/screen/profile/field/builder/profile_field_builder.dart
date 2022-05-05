import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/phone_number_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/screen/profile/field/builder/components/country_code_switch.dart';
import 'package:tapea/screen/profile/field/builder/components/header_bar.dart';
import 'package:tapea/screen/profile/field/builder/components/suggestions_builder.dart';
import 'package:tapea/screen/profile/field/builder/components/title_textfield.dart';
import 'package:tapea/util/util.dart';
import 'package:tapea/widget/borderless_text_field.dart';

class ProfileFieldScreenBuilder extends StatefulWidget {
  final String title;
  final String fieldTitlePrefix;
  final String textFieldLabel;
  final bool withSuggestions;
  final bool withLabel;
  final Widget? suggestionTitle;
  final List<String> suggestions;
  final ProfileField field;
  final VoidCallback onSaved;
  const ProfileFieldScreenBuilder({
    Key? key,
    required this.title,
    this.fieldTitlePrefix = '',
    required this.textFieldLabel,
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
    required this.suggestions,
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
    print('save()');
    if (_titleController.text.isEmpty) {
      notify(
        msg: getErrorMessageFor(
          widget.field.displayName,
        ),
        context: context,
      );
      return false;
    } else {
      final profile = context.read<ProfileNotifier>().profile;
      widget.field.profileTitle = _titleController.text;
      widget.field.profileSubtitle = _labelController.text;
      if (_phoneExtController != null) {
        if (widget.field is PhoneNumberField) {
          ((widget.field) as PhoneNumberField).phoneExt =
              _phoneExtController!.text;
        }
      }
      if (widget.field is LinkField) {
        print('saving link field!');
        ((widget.field) as LinkField).setLink(
          'https://www.' + _titleController.text.toLowerCase() + '.com',
        );
      }
      profile.fields.add(widget.field);
      return true;
    }
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
              HeaderBar(
                icon: widget.field.icon,
                field: widget.field,
                titleController: _titleController,
                labelController: _labelController,
                phoneExtController: _phoneExtController,
              ),
              TitleTextField(
                field: widget.field,
                titleController: _titleController,
                phoneExtController: _phoneExtController,
                internationalNumber: internationalNumber,
                onCountryChanged: onCountryChanged,
                label: widget.textFieldLabel,
              ),
              if (widget.field is PhoneNumberField) ...{
                CountryCodeSwitch(
                  onSwitch: onSwitch,
                  useCountryCode: internationalNumber,
                )
              },
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
                const SizedBox(
                  height: 10,
                ),
                SuggestionsBuilder(
                  suggestions: widget.suggestions,
                  onPressed: onSuggestionPressed,
                )
              }
            ],
          );
        }),
        animation: Listenable.merge([
          _titleController,
          _labelController,
          if (_phoneExtController != null) ...{
            _phoneExtController,
          }
        ]),
      ),
    );
  }

  void onCountryChanged(CountryCode code) {
    setState(() => _code = code);
  }

  void onSwitch(bool value) {
    setState(() => internationalNumber = value);
  }

  void onSuggestionPressed(String suggestion) {
    _labelController.text = suggestion;
  }

  String fullPhoneNumber() {
    return getCode() + _titleController.text;
  }

  String getCode() {
    return internationalNumber ? _code.toString() : '';
  }
}
