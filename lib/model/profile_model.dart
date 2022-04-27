enum ProfileFieldType {
  title,
  firstName,
  lastName,
  jobTitle,
  company,
  phoneNumber,
  phoneExt,
}

extension ProfileFieldTypeExtension on ProfileFieldType {
  static bool _label(ProfileFieldType type) {
    return type == ProfileFieldType.phoneExt;
  }

  static String _id(ProfileFieldType field) {
    switch (field) {
      case ProfileFieldType.title:
        return 'title';
      case ProfileFieldType.firstName:
        return 'firstName';
      case ProfileFieldType.lastName:
        return 'lastName';
      case ProfileFieldType.jobTitle:
        return 'jobTitle';
      case ProfileFieldType.company:
        return 'company';
      case ProfileFieldType.phoneNumber:
        return 'phoneNumber';
      case ProfileFieldType.phoneExt:
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
  final Map<String, dynamic> fields;
  final Map<String, dynamic> labels;

  ProfileModel({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.company,
    this.photoUrl,
    this.fields = const {
      'phoneNumber': null,
      'phoneExt': null,
    },
    this.labels = const {
      'phoneNumber': null,
    },
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

  Map<String, dynamic> getInitializedFields() {
    final Map<String, dynamic> data = {};
    fields.forEach((key, value) {
      if (value != null) {
        data[key] = value;
      }
    });
    return data;
  }

  Map<String, dynamic> getInitializedLabels() {
    final Map<String, dynamic> data = {};
    labels.forEach((key, value) {
      if (value != null) {
        data[key] = value;
      }
    });
    return data;
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
      default:
        if (type.isLabel) {
          return labels[type.id];
        } else {
          return fields[type.id];
        }
    }
  }

  @override
  String toString() {
    return 'ProfileModel(title: $title, firstName: $firstName, lastName: $lastName, jobTitle: $jobTitle, company: $company, photoUrl: $photoUrl, phoneNumber: ${fields['phoneNumber']}, phoneExt: ${labels['phoneNumber']})';
  }
}
