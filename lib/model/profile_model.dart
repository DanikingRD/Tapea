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
}

class ProfileModel {
  final String title;
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String company;
  final String? photoUrl;
  // Optional fields
  final Map<String, dynamic>? labels;
  final String? phoneNumber;
  final String? phoneExt;

  ProfileModel({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.company,
    this.photoUrl,
    this.labels,
    this.phoneNumber,
    this.phoneExt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    return ProfileModel(
      title: map['title'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      jobTitle: map['jobTitle'],
      company: map['company'],
      photoUrl: map['photoUrl'],
      labels: map['labels'],
      phoneNumber: map['phoneNumber'],
      phoneExt: map['phoneExt'],
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
      'labels': labels,
      'phoneNumber': phoneNumber,
      'phoneExt': phoneExt,
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
      case ProfileTextFieldType.phoneNumber:
        return phoneNumber;
      case ProfileTextFieldType.phoneExt:
        return phoneExt;
    }
  }

  @override
  String toString() {
    return 'ProfileModel(title: $title, firstName: $firstName, lastName: $lastName, jobTitle: $jobTitle, company: $company, photoUrl: $photoUrl, phoneNumber: $phoneNumber, phoneExt: $phoneExt)';
  }
}
