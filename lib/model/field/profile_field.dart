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
  companyWebsite,
  linkedIn,
  paypal,
  instagram,
  twitter,
  facebook,
  youtube,
  discord,
  telegram,
  tiktok,
  twitch
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
      case ProfileFieldType.companyWebsite:
        return FieldIdentifier.companyWebsite;
      case ProfileFieldType.linkedIn:
        return FieldIdentifier.linkedIn;
      case ProfileFieldType.paypal:
        return FieldIdentifier.paypal;
      case ProfileFieldType.instagram:
        return FieldIdentifier.instagram;
      case ProfileFieldType.twitter:
        return FieldIdentifier.twitter;
      case ProfileFieldType.facebook:
        return FieldIdentifier.facebook;
      case ProfileFieldType.youtube:
        return FieldIdentifier.youtube;
      case ProfileFieldType.discord:
        return FieldIdentifier.discord;
      case ProfileFieldType.telegram:
        return FieldIdentifier.telegram;
      case ProfileFieldType.tiktok:
        return FieldIdentifier.tiktok;
      case ProfileFieldType.twitch:
        return FieldIdentifier.twitch;
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
  static const String color = 'color';
  static const String phoneNumber = 'phoneNumber';
  static const String email = 'email';
  static const String link = 'link';
  static const String location = 'location';
  static const String companyWebsite = 'companyWebsite';
  static const String linkedIn = 'linkedIn';
  static const String paypal = 'paypal';
  static const String instagram = 'instagram';
  static const String twitter = 'twitter';
  static const String facebook = 'facebook';
  static const String youtube = 'youtube';
  static const String discord = 'discord';
  static const String telegram = 'telegram';
  static const String tiktok = 'tiktok';
  static const String twitch = 'twitch';
  static const String fields = 'fields';
}

// Represents a Profile field.
abstract class ProfileField {
  String title;
  String subtitle;

  ProfileField({
    required this.title,
    required this.subtitle,
  });

  String get route;
  String get displayName;
  IconData get icon;
  ProfileFieldType get type;

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
