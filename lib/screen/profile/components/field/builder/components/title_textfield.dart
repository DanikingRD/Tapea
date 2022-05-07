import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/phone_number_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/widget/borderless_text_field.dart';

class TitleTextField extends StatelessWidget {
  final ProfileField field;
  final TextEditingController titleController;
  final TextEditingController? phoneExtController;
  final String label;
  final Function(CountryCode code) onCountryChanged;
  final bool internationalNumber;
  final TextInputType? titleKeyboard;
  const TitleTextField({
    Key? key,
    required this.field,
    required this.titleController,
    required this.phoneExtController,
    required this.internationalNumber,
    required this.onCountryChanged,
    required this.label,
    this.titleKeyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (field is PhoneNumberField) {
      return Row(
        children: [
          if (internationalNumber) ...{
            Align(
              alignment: Alignment.topCenter,
              child: CountryCodePicker(
                initialSelection: 'DO',
                favorite: const ['DO', 'US'],
                onChanged: (CountryCode code) {
                  onCountryChanged(code);
                },
              ),
            ),
          } else ...{
            const SizedBox(width: 20)
          },
          Expanded(
            flex: 2,
            child: BorderlessTextField(
              controller: titleController,
              floatingLabel: 'Phone Number',
              keyboardType: TextInputType.phone,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: BorderlessTextField(
                controller: phoneExtController,
                floatingLabel: 'Ext.',
                keyboardType: TextInputType.phone,
              ),
            ),
          ),
        ],
      );
    } else {
      return field is LinkField
          ? Column(
              children: [
                getTextField(),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: FaIcon(
                          FontAwesomeIcons.link,
                          color: Colors.grey,
                          size: 16,
                        ),
                      ),
                      if (titleController.text.isNotEmpty) ...{
                        Expanded(
                          child: Text(
                            (field as LinkField).getUrl(getTitleString()),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      }
                    ],
                  ),
                )
              ],
            )
          : getTextField();
    }
  }

  String getTitleString() {
    return titleController.text.replaceAll('@', '');
  }

  Widget getTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: BorderlessTextField(
        controller: titleController,
        floatingLabel: label,
        keyboardType: titleKeyboard,
      ),
    );
  }
}
