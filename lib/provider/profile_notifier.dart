import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tapea/model/card_model.dart';
import 'package:tapea/provider/user_notifier.dart';
import 'package:tapea/service/firestore_datadase_service.dart';

class ProfileNotifier extends ChangeNotifier {
  ProfileModel? _profile;

  ProfileModel get profile => _profile!;

  Future<void> update(BuildContext context) async {
    final id = context.read<UserNotifier>().user.id;
    final database = context.read<FirestoreDatabaseService>();
    _profile = await database.readProfile(userId: id);
    notifyListeners();
  }
}
