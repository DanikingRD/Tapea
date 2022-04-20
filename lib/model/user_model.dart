class UserModel {
  final String id;
  final int profiles;
  UserModel({required this.id, required this.profiles});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'profiles': profiles};
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(id: map['id'], profiles: map['profiles']);
  }

  @override
  String toString() => 'UserModel(id: $id, profiles: $profiles)';
}
