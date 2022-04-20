import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _instance;

  FirebaseStorageService(this._instance);

  Future<void> uploadProfilePhoto({
    required String userId,
    required String profileTitle,
    required Uint8List photo,
    Function(String)? onSuccess,
    Function(String)? onFail,
  }) async {
    try {
      Reference ref = _instance
          .ref()
          .child('users')
          .child(userId)
          .child(profileTitle)
          .child('Avatar');
      TaskSnapshot task = await ref.putData(
        photo,
        SettableMetadata(
          contentType: 'image/jpg',
        ),
      );
      print('photo uploaded at bucket ${ref.bucket}');
      final String url = await task.ref.getDownloadURL();
      if (onSuccess != null) onSuccess(url);
    } on FirebaseException catch (exception) {
      if (onFail != null) onFail(exception.message!);
    }
  }
}
