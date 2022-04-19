class UserModel {
  final String id;
  UserModel({
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
    );
  }

  @override
  String toString() => 'UserModel(id: $id)';
}
