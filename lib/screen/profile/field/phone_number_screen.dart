import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/field/phone_number_field.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/screen/profile/field/profile_field_builder.dart';
import 'package:tapea/util/util.dart';
import 'package:tapea/widget/borderless_text_field.dart';
import 'package:tapea/widget/suggestion_button.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _phoneExtController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();

  CountryCode _code = CountryCode.fromJson(codes[61]);
  bool internationalNumber = true;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _phoneExtController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      title: 'Add Phone Number',
      fieldTitle: getFieldTitle(context),
      content: getContent(),
      suggestions: getSuggestions(),
      labelController: _labelController,
      subtitle: getSubtitle(),
      save: save,
    );
  }

  void save(ProfileNotifier notifier) {
    if (saveFilter()) onSave(notifier);
  }

  void onSave(ProfileNotifier notifier) {
    notifier.profile.fields.add(
      PhoneNumberField(
        title: _phoneNumberController.text,
        subtitle: _labelController.text,
        phoneExtension: _phoneExtController.text,
      ),
    );
  }

  bool saveFilter() {
    if (_phoneNumberController.text.isEmpty) {
      notify(
        context: context,
        msg:
            'Enter your phone number if you want to save this field to your profile.',
      );
      return false;
    } else {
      return true;
    }
  }

  String fullPhoneNumber() {
    return getCode() + _phoneNumberController.text;
  }

  Widget? getSubtitle() {
    return _labelController.text.isEmpty
        ? null
        : Text(
            _labelController.text,
          );
  }

  String getCode() {
    return internationalNumber ? _code.toString() : '';
  }

  List<Widget> getContent() {
    final padding = EdgeInsets.only(left: internationalNumber ? 0 : 20);
    return [
      Row(
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
            child: Padding(
              padding: padding,
              child: BorderlessTextField(
                controller: _phoneNumberController,
                floatingLabel: 'Phone Number',
                keyboardType: TextInputType.phone,
                onChanged: (_) => setState((() => {})),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: BorderlessTextField(
                controller: _phoneExtController,
                floatingLabel: 'Ext.',
                onChanged: (_) => setState(() => {}),
                keyboardType: TextInputType.phone,
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: buildSwitch(),
          ),
          Text(
            'Use international number',
            style: TextStyle(color: Colors.grey[700]),
          ),
        ],
      ),
    ];
  }

  Widget getFieldTitle(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          fullPhoneNumber(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (_phoneExtController.text.isNotEmpty) ...{
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Ext. ' + _phoneExtController.text,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: Colors.grey[600],
              ),
            ),
          )
        }
      ],
    );
  }

  Widget buildSwitch() {
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

  Widget getSuggestions() {
    return Row(
      children: [
        getButton('Home'),
        getButton('Mobile'),
        getButton('Work'),
        getButton('Cell')
      ],
    );
  }

  Widget getButton(String suggestion) {
    return SuggestionButton(
        suggestion: suggestion,
        onPressed: () {
          setState(
            () => _labelController.text = suggestion,
          );
        });
  }
}
