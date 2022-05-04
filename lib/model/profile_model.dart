import 'package:tapea/model/field/email_field.dart';
import 'package:tapea/model/field/location_field.dart';
import 'package:tapea/model/field/phone_number_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/model/field/link_field.dart';

class ProfileModel {
  final String title;
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String company;
  final String? photoUrl;
  final List<ProfileField> fields;

  const ProfileModel({
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
      title: json[FieldIdentifier.title],
      firstName: json[FieldIdentifier.firstName],
      lastName: json[FieldIdentifier.lastName],
      jobTitle: json[FieldIdentifier.jobTitle],
      company: json[FieldIdentifier.company],
      photoUrl: json['photoUrl'],
      fields: fieldsFromJson(json['fields']),
    );
  }

  ProfileModel copyWith({
    String? title,
    String? firstName,
    String? lastName,
    String? jobTitle,
    String? company,
    String? photoUrl,
    List<ProfileField>? fields,
  }) {
    return ProfileModel(
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
        case FieldIdentifier.email:
          allFields.add(
            EmailField(
              title: title,
              subtitle: subtitle,
            ),
          );
          break;
        case FieldIdentifier.link:
          allFields.add(
            LinkField(
              title: title,
              subtitle: subtitle,
            ),
          );
          break;
        case FieldIdentifier.location:
          allFields.add(
            LocationField(
              title: title,
              subtitle: subtitle,
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
