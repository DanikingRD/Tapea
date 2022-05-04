// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';

enum ProfileFieldType {
  title,
  firstName,
  lastName,
  company,
  jobTitle,
  phoneNumber,
  email,
  link,
  location,
}

extension ProfileTypeExt on ProfileFieldType {
  static String _id(ProfileFieldType field) {
    switch (field) {
      case ProfileFieldType.title:
        return FieldIdentifier.title;
      case ProfileFieldType.firstName:
        return FieldIdentifier.firstName;
      case ProfileFieldType.lastName:
        return FieldIdentifier.lastName;
      case ProfileFieldType.company:
        return FieldIdentifier.company;
      case ProfileFieldType.jobTitle:
        return FieldIdentifier.jobTitle;
      case ProfileFieldType.phoneNumber:
        return FieldIdentifier.phoneNumber;
      case ProfileFieldType.email:
        return FieldIdentifier.email;
      case ProfileFieldType.link:
        return FieldIdentifier.link;
      case ProfileFieldType.location:
        return FieldIdentifier.location;
    }
  }

  String get id => _id(this);
}

class FieldIdentifier {
  static const String title = 'title';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String jobTitle = 'jobTitle';
  static const String company = 'company';
  static const String phoneNumber = 'phoneNumber';
  static const String email = 'email';
  static const String link = 'link';
  static const String location = 'location';
  static const String fields = 'fields';
}

// Represents a Profile field.
abstract class ProfileField {
  String title;
  String subtitle;
  final IconData icon;
  final ProfileFieldType type;

  ProfileField({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.type,
  });

  String get displayName;

  set profileTitle(String title) => this.title = title;
  set profileSubtitle(String subtitle) => this.subtitle = subtitle;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProfileField && other.title == title && other.type == type;
  }

  @override
  int get hashCode => title.hashCode ^ type.hashCode;
}
