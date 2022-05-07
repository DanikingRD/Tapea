import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/service/firestore_datadase_service.dart';
import 'package:tapea/util/util.dart';

class ProfileNotifier extends ChangeNotifier {
  ProfileModel? _profile;
  Color? _color;

  ProfileModel get profile => _profile!;
  Color get color => _color!;

  set color(Color color) {
    _color = color;
    notifyListeners();
  }

  Future<void> update(BuildContext context) async {
    final String? id = getIdentifier(context);
    if (id != null) {
      final database = context.read<FirestoreDatabaseService>();
      _profile = await database.readDefaultProfile(userId: id);
      _color = Color(_profile!.color).withOpacity(1);
      notifyListeners();
    }
  }
}
