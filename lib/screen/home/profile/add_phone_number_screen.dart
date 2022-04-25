import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/provider/user_notifier.dart';
import 'package:tapea/service/firestore_datadase_service.dart';
import 'package:tapea/util/util.dart';
import 'package:tapea/widget/borderless_text_field.dart';
import 'package:tapea/widget/circle_icon.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _phoneExt = TextEditingController();
  final TextEditingController _optionalField = TextEditingController();
  final CountryCode code = CountryCode.fromJson(codes[61]);
  bool internationalNumber = true;

  Future<void> saveChanges(String userId) async {
    final database = context.read<FirestoreDatabaseService>();
    final title = context.read<UserNotifier>().user.defaultProfile;
    await database.updateProfile(
      userId: userId,
      title: title,
      data: {
        'labels': {
          ProfileTextFieldType.phoneNumber.id: _optionalField.text,
        },
        'phoneNumber': _phoneNumberController.text,
        'phoneExt': _phoneExt.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = EdgeInsets.only(left: internationalNumber ? 0 : 20);
    return Scaffold(
      backgroundColor: kHomeBgColor,
      appBar: AppBar(
        title: const Text('Add Phone Number'),
        backgroundColor: kHomeBgColor,
        actions: [
          TextButton(
            onPressed: () async {
              final String? userId = getIdentifier(context);
              if (userId != null) {
                await saveChanges(userId);
              }
              Navigator.pop(context);
            },
            child: const Text(
              'SAVE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const Divider(
            thickness: 6.0,
            color: kFieldIconScreenDivider,
          ),
          ListTile(
            leading: const CircleIcon(
              backgroundColor: kSelectedPageColor,
              iconData: FontAwesomeIcons.phone,
              iconSize: 24,
              circleSize: 48,
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    getCountryCode() + _phoneNumberController.text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_phoneExt.text.isNotEmpty) ...{
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        'Ext. ' + _phoneExt.text,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.disabledColor,
                        ),
                      ),
                    )
                  }
                ],
              ),
            ),
            subtitle: _optionalField.text.isEmpty
                ? null
                : Text(
                    _optionalField.text,
                  ),
          ),
          const Divider(
            thickness: 6.0,
            color: kFieldIconScreenDivider,
          ),
          Row(
            children: [
              if (internationalNumber) ...{
                Align(
                  alignment: Alignment.topCenter,
                  child: CountryCodePicker(
                    initialSelection: 'DO',
                    favorite: const ['DO', 'US'],
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
                    controller: _phoneExt,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BorderlessTextField(
              controller: _optionalField,
              floatingLabel: 'Label (optional)',
              onChanged: (_) => setState(() => {}),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Here are some suggestions for your label:',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Align(
                child: getButton('Home'),
              ),
              Align(
                child: getButton('Mobile'),
              ),
              Align(
                child: getButton('Work'),
              ),
              Align(
                child: getButton('Cell'),
              )
            ],
          ),
        ],
      ),
    );
  }

  String getCountryCode() {
    return internationalNumber ? code.toString() : '';
  }

  Widget getButton(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OutlinedButton(
        onPressed: () => setState(() => _optionalField.text = name),
        child: Text(
          name,
          style: const TextStyle(color: kRedColor, fontWeight: FontWeight.bold),
        ),
        style: OutlinedButton.styleFrom(
          primary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
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
}
