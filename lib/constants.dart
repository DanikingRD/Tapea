import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/util/field_identifiers.dart';
import 'package:tapea/util/text_field_manager.dart';

const Color kRedColor = Color.fromARGB(255, 221, 10, 46);
const Color kSelectedPageColor = Color.fromARGB(255, 252, 80, 108);
const Color kProfileEditorFieldContainer = Color.fromARGB(255, 255, 211, 211);
const Color kFieldIconScreenDivider = Color.fromARGB(255, 255, 223, 223);
const double kMobileScreenWidth = 600;
const double kTabletScreenWidth = 900;
const double kDesktopScreenWidth = 1200;
const kSplashRadius = Material.defaultSplashRadius * 0.70; // 70%
const kHomeBgColor = Color.fromARGB(255, 253, 251, 244);
const kProgressIndicatorBox = Color.fromARGB(255, 234, 226, 203);
const List<FieldManager> kGlobalProfileFields = [
  FieldManager(
    titleLabel: 'Phone Number',
    type: ProfileFieldType.phoneNumber,
    icon: FontAwesomeIcons.phone,
  ),
];
