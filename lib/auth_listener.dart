import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tapea/service/firebase_auth_service.dart';
import 'package:tapea/widget/loading_indicator.dart';

class AuthListener extends StatelessWidget {
  final Widget root;
  final Widget home;
  const AuthListener({
    Key? key,
    required this.root,
    required this.home,
  }) : super(key: key);

  ///An Authentication Gateway for the App.
  ///
  ///If the User is logged in, it automatically redirects to the destination
  ///and if the user is not logged in, it redirects to the login
  ///can also accomodate a customWaitingScreen or a default one if needed.
  ///
  ///[root] (required) - The Login View
  ///
  ///[home] (required) - The Destination View
  @override
  Widget build(BuildContext context) {
    final service = context.watch<FirebaseAuthService>();
    return StreamBuilder(
      stream: service.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator();
        }
        if (!snapshot.hasData || snapshot.hasError) {
          return root;
        } else {
          return home;
        }
      },
    );
  }
}
