class UserModel {
  final String id;
  final int profiles;
  final String defaultProfile;

  UserModel({
    required this.id,
    required this.profiles,
    required this.defaultProfile,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'profiles': profiles,
      'defaultProfile': defaultProfile
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      profiles: map['profiles'],
      defaultProfile: map['defaultProfile'],
    );
  }

  @override
  String toString() =>
      'UserModel(id: $id, profiles: $profiles, defaultProfile: $defaultProfile)';
}
