import 'package:tapea/util/field_identifiers.dart';

class ProfileModel {
  final String title;
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String company;
  final String? photoUrl;
  final List<dynamic> phoneNumbers;
  final Map<dynamic, dynamic> labels;

  ProfileModel({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.company,
    this.photoUrl,
    this.phoneNumbers = const [],
    this.labels = const {},
  });

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    return ProfileModel(
      title: map[ProfileFieldID.title],
      firstName: map[ProfileFieldID.firstName],
      lastName: map[ProfileFieldID.lastName],
      jobTitle: map[ProfileFieldID.jobTitle],
      company: map[ProfileFieldID.company],
      photoUrl: map['photoUrl'],
      phoneNumbers: map[ProfileFieldID.phoneNumbers],
      labels: map['labels'],
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
      ProfileFieldID.phoneNumbers: phoneNumbers,
      'labels': labels,
    };
  }

  Map<String, List<dynamic>> mapFields() {
    return {
      ProfileFieldID.phoneNumbers: phoneNumbers,
    };
  }

  Object? getFieldByType(ProfileFieldType type) {
    switch (type) {
      case ProfileFieldType.title:
        return title;
      case ProfileFieldType.firstName:
        return firstName;
      case ProfileFieldType.lastName:
        return lastName;
      case ProfileFieldType.jobTitle:
        return jobTitle;
      case ProfileFieldType.company:
        return company;
      case ProfileFieldType.phoneNumber:
        return phoneNumbers;
      default:
        if (type.isLabel) {
          return labels;
        }
    }
  }

  @override
  String toString() {
    return 'ProfileModel(title: $title, firstName: $firstName, lastName: $lastName, jobTitle: $jobTitle, company: $company, photoUrl: $photoUrl, phoneNumbers: $phoneNumbers)';
  }
}
