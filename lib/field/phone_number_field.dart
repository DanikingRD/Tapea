import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/field/profile_field.dart';

class PhoneNumberField extends ProfileField {
  final String? phoneExtension;

  PhoneNumberField({
    required String title,
    required String subtitle,
    this.phoneExtension,
  }) : super(
          title: title,
          subtitle: subtitle,
          icon: FontAwesomeIcons.phone,
          type: ProfileFieldType.phoneNumber,
          floatingLabel: 'Phone Number',
        );
  String getPhoneNumber() {
    if (phoneExtension != null) {
      return title + ' ' + 'Ext.' + phoneExtension!;
    } else {
      return title;
    }
  }
}
