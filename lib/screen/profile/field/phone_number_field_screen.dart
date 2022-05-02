import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/field/phone_number_field.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/screen/profile/field/profile_field_builder.dart';
import 'package:tapea/util/util.dart';
import 'package:tapea/widget/borderless_text_field.dart';

class PhoneNumberFieldScreen extends StatefulWidget {
  const PhoneNumberFieldScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PhoneNumberFieldScreen> createState() => _PhoneNumberFieldScreenState();
}

class _PhoneNumberFieldScreenState extends State<PhoneNumberFieldScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _phoneExtController = TextEditingController();
  CountryCode _code = CountryCode.fromJson(codes[61]);
  bool internationalNumber = true;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _phoneExtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: ((context, child) {
        return ProfileFieldScreenBuilder(
          title: 'Add Phone Number',
          fieldTitle: getFieldTitle(context),
          fieldIcon: FontAwesomeIcons.phone,
          textFieldLabel: 'Phone Number',
          isPhoneNumberField: true,
          content: getContent(),
          suggestions: const ['Home', 'Mobile', 'Work', 'Cell'],
          save: save,
        );
      }),
      animation: Listenable.merge([
        _phoneNumberController,
        _phoneExtController,
      ]),
    );
  }

  void save(String? titleText, String labelText, ProfileNotifier notifier) {
    if (_phoneNumberController.text.isEmpty) {
      notify(msg: getFilterMessage(), context: context);
    } else {
      notifier.profile.fields.add(
        PhoneNumberField(
          title: _phoneNumberController.text,
          subtitle: labelText,
          phoneExtension: _phoneExtController.text,
        ),
      );
      Navigator.pop(context);
    }
  }

  String getFilterMessage() {
    return 'Enter your phone number if you want to save this field to your profile.';
  }

  String fullPhoneNumber() {
    return getCode() + _phoneNumberController.text;
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
              ),
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
      ),
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
