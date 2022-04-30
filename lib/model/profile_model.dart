import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/field/phone_number_field.dart';
import 'package:tapea/field/profile_field.dart';
import 'package:tapea/util/field_identifiers.dart';

class ProfileModel {
  final String title;
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String company;
  final String? photoUrl;
  final List<ProfileField> fields;

  ProfileModel({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.company,
    this.photoUrl,
    this.fields = const [],
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      title: json[ProfileFieldID.title],
      firstName: json[ProfileFieldID.firstName],
      lastName: json[ProfileFieldID.lastName],
      jobTitle: json[ProfileFieldID.jobTitle],
      company: json[ProfileFieldID.company],
      photoUrl: json['photoUrl'],
      fields: fieldsFromJson(json['fields']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ProfileFieldID.title: title,
      ProfileFieldID.firstName: firstName,
      ProfileFieldID.lastName: lastName,
      ProfileFieldID.jobTitle: jobTitle,
      ProfileFieldID.company: company,
      'photoUrl': photoUrl,
      ProfileFieldID.fields: fieldsToJson(),
    };
  }

  static List<ProfileField> fieldsFromJson(List<Map<String, dynamic>> fields) {
    print(fields);
    final List<ProfileField> allFields = [];
    for (Map<String, dynamic> field in fields) {
      if (field.isEmpty) continue;
      final String title = field['title'];
      final String subtitle = field['subtitle'];
      switch (field['type']) {
        case 0:
          allFields.add(PhoneNumberField(
              title: title,
              subtitle: subtitle,
              phoneExtension: field['phoneExtension'],
              icon: FontAwesomeIcons.phone));
          break;
        default:
          throw ('');
      }
    }
    return allFields;
  }

  List<Map<String, dynamic>> fieldsToJson() {
    final List<Map<String, dynamic>> allJsons = [];
    for (ProfileField field in fields) {
      allJsons.add(
        {
          'type': field.type.id,
          'title': field.title,
          'subtitle': field.subtitle,
        },
      );
    }
    print(allJsons);
    return allJsons;
  }

  @override
  String toString() {
    return 'ProfileModel(title: $title, firstName: $firstName, lastName: $lastName, jobTitle: $jobTitle, company: $company, photoUrl: $photoUrl)';
  }
}
