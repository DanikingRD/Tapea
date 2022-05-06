import 'package:flutter/src/widgets/icon_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/phone_number_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/routes.dart';

class PhoneNumberFieldImpl extends PhoneNumberField {
  PhoneNumberFieldImpl({
    String title = '',
    String subtitle = '',
    String ext = '',
  }) : super(title: title, subtitle: subtitle, ext: ext);
  @override
  String get displayName => 'Phone Number';

  @override
  IconData get icon => FontAwesomeIcons.phone;

  @override
  String get route => Routes.phoneNumberField;

  @override
  ProfileFieldType get type => ProfileFieldType.phoneNumber;
}
