enum ProfileTextFieldType {
  title,
  firstName,
  lastName,
  jobTitle,
  company,
  phoneNumber,
  phoneExt,
}

extension ProfileFieldTypeExtension on ProfileTextFieldType {
  static bool _label(ProfileTextFieldType type) {
    return type == ProfileTextFieldType.phoneExt;
  }

  static String _id(ProfileTextFieldType field) {
    switch (field) {
      case ProfileTextFieldType.title:
        return 'title';
      case ProfileTextFieldType.firstName:
        return 'firstName';
      case ProfileTextFieldType.lastName:
        return 'lastName';
      case ProfileTextFieldType.jobTitle:
        return 'jobTitle';
      case ProfileTextFieldType.company:
        return 'company';
      case ProfileTextFieldType.phoneNumber:
        return 'phoneNumber';
      case ProfileTextFieldType.phoneExt:
        return 'phoneExt';
    }
  }

  String get id => _id(this);
  bool get isLabel => _label(this);
}

class ProfileModel {
  final String title;
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String company;
  final String? photoUrl;
  // Optional fields
  final Map<String, dynamic>? fields;
  final Map<String, dynamic>? labels;

  ProfileModel({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.company,
    this.photoUrl,
    this.fields,
    this.labels,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    return ProfileModel(
      title: map['title'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      jobTitle: map['jobTitle'],
      company: map['company'],
      photoUrl: map['photoUrl'],
      fields: map['fields'],
      labels: map['labels'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'jobTitle': jobTitle,
      'company': company,
      'photoUrl': photoUrl,
      'fields': fields,
      'labels': labels,
    };
  }

  Object? getFieldByType(ProfileTextFieldType type) {
    switch (type) {
      case ProfileTextFieldType.title:
        return title;
      case ProfileTextFieldType.firstName:
        return firstName;
      case ProfileTextFieldType.lastName:
        return lastName;
      case ProfileTextFieldType.jobTitle:
        return jobTitle;
      case ProfileTextFieldType.company:
        return company;
      default:
        if (type.isLabel) {
          if (labels == null) {
            return null; // Prevents 'Null check operator used on a null value'.
          } else {
            return labels![type.id];
          }
        } else {
          if (fields == null) {
            return null; // Prevents 'Null check operator used on a null value'.
          } else {
            return fields![type.id];
          }
        }
    }
  }

  @override
  String toString() {
    return 'ProfileModel(title: $title, firstName: $firstName, lastName: $lastName, jobTitle: $jobTitle, company: $company, photoUrl: $photoUrl, phoneNumber: ${fields!['phoneNumber']}, phoneExt: ${labels!['phoneNumber']})';
  }
}
