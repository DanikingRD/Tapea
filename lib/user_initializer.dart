import 'package:firebase_auth/firebase_auth.dart';
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
  late final Future<bool>? hasUser;
  @override
  void initState() {
    super.initState();
    String? id = getIdentifier(context);
    if (id != null) {
      hasUser = checkUser(id);
    } else {
      hasUser = null;
    }
  }

  Future<bool> checkUser(String id) async {
    final database = context.read<FirestoreDatabaseService>();
    return database.containsUser(id);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    // Signed in
    if (user != null) {
      if (!user.emailVerified) {
        return const VerificationScreen();
      }
      return FutureBuilder<bool>(
        future: hasUser,
        builder: ((BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data!) {
              // There is a record of this user
              return const HomeScreen();
            } else {
              // This is a new user without record
              return const ProfileSetupScreen();
            }
          } else {
            // Data is loading
            if (ConnectionState.waiting == snapshot.connectionState) {
              return const LoadingIndicator();
            } else {
              // The data never arrived?.
              return const LoginScreen();
            }
          }
        }),
      );
    } else {
      // Not signed in
      return const LoginScreen();
    }
  }
}
