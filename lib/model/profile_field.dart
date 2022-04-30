import 'package:flutter/widgets.dart';

// Represents a Profile field.
class ProfileField {
  final String title;
  final String subtitle;
  final IconData icon;

  const ProfileField({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
