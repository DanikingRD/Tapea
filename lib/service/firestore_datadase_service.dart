import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/model/user_model.dart';

class FirestoreDatabaseService {
  final FirebaseFirestore _instance;

  FirestoreDatabaseService(this._instance);

  Future<void> addUser({
    required UserModel user,
  }) async {
    await usersRef().doc(user.id).set(user);
  }

  Future<void> addUserProfile({
    required String userId,
    required ProfileModel profile,
  }) async {
    await profilesRef(userId: userId).doc(profile.title).set(profile);
  }

  Future<void> addDefaultUserProfile({
    required String userId,
    required ProfileModel profile,
  }) async {
    await profilesRef(userId: userId).doc('Default').set(profile);
  }

  Future<UserModel> readUser(String userId) async {
    final json = await usersRef().doc(userId).get();
    return json.data()!;
  }

  Future<void> updateUser({
    required String userId,
    required Map<String, Object?> data,
  }) async {
    await usersRef().doc(userId).update(data);
  }

  Future<bool> containsUser(String id) async {
    final DocumentSnapshot<UserModel> doc = await usersRef().doc(id).get();
    return doc.exists;
  }

  Future<ProfileModel> readDefaultProfile({
    required String userId,
  }) async {
    final json = await profilesRef(userId: userId).doc('Default').get();
    return json.data()!;
  }

  Future<ProfileModel> readProfile({
    required String userId,
    required String title,
  }) async {
    final json = await profilesRef(userId: userId).doc(title).get();
    return json.data()!;
  }

  Future<void> updateDefaultProfile({
    required String userId,
    required Map<String, Object?> data,
  }) async {
    await profilesRef(userId: userId).doc('Default').update(data);
  }

  Future<void> updateProfile({
    required String userId,
    required String title,
    required Map<String, Object?> data,
  }) async {
    await profilesRef(userId: userId).doc(title).update(data);
  }

  CollectionReference<UserModel> usersRef() {
    return _instance.collection('users').withConverter<UserModel>(
          fromFirestore: (doc, _) => UserModel.fromJson(doc.data()!),
          toFirestore: (UserModel model, _) => model.toJson(),
        );
  }

  CollectionReference<ProfileModel> profilesRef({
    required String userId,
  }) {
    return _instance
        .collection('users')
        .doc(userId)
        .collection('profiles')
        .withConverter<ProfileModel>(
            fromFirestore: (doc, _) => ProfileModel.fromJson(doc.data()!),
            toFirestore: (model, _) => model.toJson());
  }
}
