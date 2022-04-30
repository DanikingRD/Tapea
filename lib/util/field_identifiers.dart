enum ProfileFieldType {
  title,
  firstName,
  lastName,
  jobTitle,
  company,
  photoUrl,
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
        return ProfileFieldID.title;
      case ProfileFieldType.firstName:
        return ProfileFieldID.firstName;
      case ProfileFieldType.lastName:
        return ProfileFieldID.lastName;
      case ProfileFieldType.jobTitle:
        return ProfileFieldID.jobTitle;
      case ProfileFieldType.company:
        return ProfileFieldID.company;
      case ProfileFieldType.photoUrl:
        return ProfileFieldID.photoUrl;
      case ProfileFieldType.phoneNumber:
        return ProfileFieldID.phoneNumbers;
      case ProfileFieldType.phoneExt:
        return ProfileFieldID.phoneExts;
    }
  }

  String get id => _id(this);
  bool get isLabel => _label(this);
}

class ProfileFieldID {
  static const String title = 'title';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String jobTitle = 'jobTitle';
  static const String company = 'company';
  static const String photoUrl = 'photoUrl';
  static const String phoneNumbers = 'phoneNumbers';
  static const String phoneExts = 'phoneExts';
}
