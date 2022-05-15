import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tapea/screen/auth/default_profile/profile_setup.dart';
import 'package:tapea/screen/auth/login/login_screen.dart';
import 'package:tapea/screen/auth/verification_screen.dart';
import 'package:tapea/screen/home_screen.dart';
import 'package:tapea/service/firebase_auth_service.dart';
import 'package:tapea/service/firestore_datadase_service.dart';
import 'package:tapea/util/util.dart';
import 'package:tapea/widget/loading_indicator.dart';

class UserInitializer extends StatefulWidget {
  const UserInitializer({
    Key? key,
  }) : super(key: key);

  @override
  State<UserInitializer> createState() => _UserInitializerState();
}

class _UserInitializerState extends State<UserInitializer> {
  late final Future<bool>? hasRecord;
  @override
  void initState() {
    super.initState();
    String? id = getIdentifier(context);
    if (id != null) {
      hasRecord = checkUser(id);
    } else {
      hasRecord = null;
    }
  }

  Future<bool> checkUser(String id) async {
    final database = context.read<FirestoreDatabaseService>();
    return database.containsUser(id);
  }

  @override
  Widget build(BuildContext context) {
    final service = context.read<FirebaseAuthService>();
    if (service.user == null) {
      return const LoginScreen();
    }
    // User is not null
    if (!service.user!.emailVerified) {
      return const VerificationScreen();
    }
    // User is signed in with email verified
    return FutureBuilder(
      future: hasRecord,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        // Waiting for data
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator();
        }
        if (snapshot.data != null) {
          // User has a profile
          if (snapshot.data!) {
            return const HomeScreen();
          } else {
            return const ProfileSetupScreen();
          }
        }
        return const LoginScreen();
      },
    );
  }
}
