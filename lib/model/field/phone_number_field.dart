import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/profile_field.dart';

class PhoneNumberField extends ProfileField {
  String? phoneExtension;

  PhoneNumberField({
    String title = '',
    String subtitle = '',
    this.phoneExtension,
  }) : super(
          title: title,
          subtitle: subtitle,
          icon: FontAwesomeIcons.phone,
          type: ProfileFieldType.phoneNumber,
        );
  String displayExtensionOnly() {
    if (phoneExtension != null) {
      return 'Ext.' ' ' + phoneExtension!;
    } else {
      return '';
    }
  }

  @override
  String get displayName => 'Phone Number';
}
