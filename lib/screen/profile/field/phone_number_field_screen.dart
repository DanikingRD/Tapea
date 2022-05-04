import 'dart:ui';

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
  final VoidCallback onSaved;
  const PhoneNumberFieldScreen({
    Key? key,
    required this.onSaved,
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
          suggestions: const ['Home', 'Mobile', 'Work', 'Cell'],
          field: PhoneNumberField(),
          onSaved: widget.onSaved,
        );
      }),
      animation: Listenable.merge([
        _phoneNumberController,
        _phoneExtController,
      ]),
    );
  }

  Widget getFieldTitle(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          'asda',
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
}
