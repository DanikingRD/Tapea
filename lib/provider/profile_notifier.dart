import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/service/firestore_datadase_service.dart';
import 'package:tapea/util/util.dart';

class ProfileNotifier extends ChangeNotifier {
  Profile? _profile;

  Profile get profile => _profile!;

  Future<void> update(BuildContext context) async {
    final String? id = getIdentifier(context);
    if (id != null) {
      final database = context.read<FirestoreDatabaseService>();
      _profile = await database.readDefaultProfile(userId: id);
      notifyListeners();
    }
  }

  void updateWith(Profile profile) {
    _profile = profile;
    notifyListeners();
  }
}
