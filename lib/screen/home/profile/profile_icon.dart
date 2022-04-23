import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ProfileIcon {
  phoneNumber,
  email,
  youtube,
}

extension ProfileIconExtension on ProfileIcon {
  static IconData _icon(ProfileIcon obj) {
    switch (obj) {
      case ProfileIcon.phoneNumber:
        return FontAwesomeIcons.phone;
      case ProfileIcon.email:
        return Icons.email;
      case ProfileIcon.youtube:
        return FontAwesomeIcons.youtube;
    }
  }

  IconData get icon => _icon(this);
}
