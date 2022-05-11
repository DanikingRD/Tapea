import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tapea/model/user_model.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/service/firebase_auth_service.dart';
import 'package:tapea/service/firestore_datadase_service.dart';

class UserNotifier extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> update(BuildContext context) async {
    final auth = context.read<FirebaseAuthService>();
    final database = context.read<FirestoreDatabaseService>();
    _user = await database.readUser(
      userId: auth.user!.uid,
    );
    notifyListeners();
  }
}
