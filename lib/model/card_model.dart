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

  @override
  String toString() {
    return 'ProfileModel(title: $title, firstName: $firstName, lastName: $lastName, jobTitle: $jobTitle, company: $company, photoUrl: $photoUrl)';
  }
}
