import 'package:flutter/widgets.dart';

enum ProfileFieldType {
  phoneNumber,
  email,
}

extension ProfileTypeExt on ProfileFieldType {
  static int _id(ProfileFieldType field) {
    switch (field) {
      case ProfileFieldType.phoneNumber:
        return 0;
      case ProfileFieldType.email:
        return 1;
    }
  }

  int get id => _id(this);
}

// Represents a Profile field.
abstract class ProfileField {
  final String title;
  final String subtitle;
  final IconData icon;
  final ProfileFieldType type;

  const ProfileField({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.type,
  });
}
