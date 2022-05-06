import 'package:flutter/src/widgets/icon_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/routes.dart';

class PhoneNumberField extends ProfileField {
  String? phoneExtension;

  PhoneNumberField({
    String title = '',
    String subtitle = '',
    this.phoneExtension,
  }) : super(
          title: title,
          subtitle: subtitle,
        );
  set phoneExt(String phoneExtension) => this.phoneExtension = phoneExtension;

  String displayExtensionOnly() {
    if (phoneExtension != null) {
      return 'Ext.' ' ' + phoneExtension!;
    } else {
      return '';
    }
  }

  @override
  String get displayName => 'Phone Number';

  @override
  IconData get icon => FontAwesomeIcons.phone;

  @override
  ProfileFieldType get type => ProfileFieldType.phoneNumber;

  @override
  String get route => Routes.phoneNumberField;
}
