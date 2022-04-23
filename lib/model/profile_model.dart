enum ProfileTextField {
  title,
  firstName,
  lastName,
  jobTitle,
  company,
}

extension ProfileTextFieldExtension on ProfileTextField {
  static String _id(ProfileTextField field) {
    switch (field) {
      case ProfileTextField.title:
        return 'title';
      case ProfileTextField.firstName:
        return 'firstName';
      case ProfileTextField.lastName:
        return 'lastName';
      case ProfileTextField.jobTitle:
        return 'jobTitle';
      case ProfileTextField.company:
        return 'company';
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

  ProfileModel({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.company,
    this.photoUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    return ProfileModel(
      title: map['title'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      jobTitle: map['jobTitle'],
      company: map['company'],
      photoUrl: map['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'jobTitle': jobTitle,
      'company': company,
      'photoUrl': photoUrl
    };
  }

  String getTextField(ProfileTextField field) {
    switch (field) {
      case ProfileTextField.title:
        return title;
      case ProfileTextField.firstName:
        return firstName;
      case ProfileTextField.lastName:
        return lastName;
      case ProfileTextField.jobTitle:
        return jobTitle;
      case ProfileTextField.company:
        return company;
    }
  }

  @override
  String toString() {
    return 'ProfileModel(title: $title, firstName: $firstName, lastName: $lastName, jobTitle: $jobTitle, company: $company, photoUrl: $photoUrl)';
  }
}
