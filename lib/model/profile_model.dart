import 'package:flutter/cupertino.dart';
import 'package:tapea/field/phone_number_field.dart';
import 'package:tapea/field/profile_field.dart';

class Profile {
  final String title;
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String company;
  final String? photoUrl;
  final List<ProfileField> fields;

  const Profile({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.company,
    this.photoUrl,
    this.fields = const [],
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      title: json[FieldIdentifier.title],
      firstName: json[FieldIdentifier.firstName],
      lastName: json[FieldIdentifier.lastName],
      jobTitle: json[FieldIdentifier.jobTitle],
      company: json[FieldIdentifier.company],
      photoUrl: json['photoUrl'],
      fields: fieldsFromJson(json['fields']),
    );
  }

  Profile copyWith({
    String? title,
    String? firstName,
    String? lastName,
    String? jobTitle,
    String? company,
    String? photoUrl,
    List<ProfileField>? fields,
  }) {
    return Profile(
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      jobTitle: jobTitle ?? this.jobTitle,
      company: company ?? this.company,
      photoUrl: photoUrl ?? this.photoUrl,
      fields: fields ?? this.fields,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      FieldIdentifier.title: title,
      FieldIdentifier.firstName: firstName,
      FieldIdentifier.lastName: lastName,
      FieldIdentifier.jobTitle: jobTitle,
      FieldIdentifier.company: company,
      'photoUrl': photoUrl,
      FieldIdentifier.fields: fieldsToJson(),
    };
  }

  static List<ProfileField> fieldsFromJson(List<dynamic> fields) {
    // 'fields' variable is actually a List<Map<String, dynamic>>.
    if (fields.isEmpty) return [];
    final List<ProfileField> allFields = [];
    for (Map<String, dynamic> field in fields) {
      final String title = field['title'];
      final subtitle = field.containsKey('subtitle') ? field['subtitle'] : '';
      switch (field['type'] as String) {
        case FieldIdentifier.phoneNumber:
          allFields.add(
            PhoneNumberField(
              title: title,
              subtitle: subtitle,
              phoneExtension: field['phoneExtension'],
            ),
          );
          break;
        default:
          throw ('');
      }
    }

    return allFields;
  }

  List<Map<String, dynamic>> fieldsToJson() {
    print('fields to json');
    final List<Map<String, dynamic>> allJsons = [];
    for (ProfileField field in fields) {
      final Map<String, dynamic> currentField = {
        'type': field.type.id,
        'title': field.title,
        'subtitle': field.subtitle,
      };
      if (field is PhoneNumberField) {
        currentField['phoneExtension'] = field.phoneExtension;
      }
      allJsons.add(currentField);
    }

    return allJsons;
  }

  @override
  String toString() {
    return 'ProfileModel(title: $title, firstName: $firstName, lastName: $lastName, jobTitle: $jobTitle, company: $company, photoUrl: $photoUrl, fields: $fields)';
  }
}
