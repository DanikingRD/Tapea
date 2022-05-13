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

class UserInitializer extends StatefulWidget {
  const UserInitializer({
    Key? key,
  }) : super(key: key);

  @override
  State<UserInitializer> createState() => _UserInitializerState();
}

class _UserInitializerState extends State<UserInitializer> {
  late final Future<bool?>? hasUser;
  @override
  void initState() {
    super.initState();
    hasUser = checkUser();
  }

  Future<bool?>? checkUser() async {
    final database = context.read<FirestoreDatabaseService>();
    final String? id = getIdentifier(context);
    return id != null ? database.containsUser(id) : null;
  }

  @override
  Widget build(BuildContext context) {
    final service = context.watch<FirebaseAuthService>();
    return StreamBuilder<User?>(
      stream: service.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (!service.isEmailVerified) {
            return const VerificationScreen();
          } else {
            return FutureBuilder<bool?>(
              future: hasUser,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return const HomeScreen();
                  } else {
                    return const ProfileSetupScreen();
                  }
                } else {
                  return const LoginScreen();
                }
              }),
            );
          }
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
