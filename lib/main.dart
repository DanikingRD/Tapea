import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapea/auth_listener.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/firebase_options.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/screen/profile_setup.dart';
import 'package:tapea/screen/welcome_screen.dart';
import 'package:tapea/service/firebase_auth_service.dart';
import 'package:flutter/services.dart';
import 'package:tapea/service/firestore_datadase_service.dart';
import 'package:tapea/util/colors.dart' as colors;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        // Android
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent),
  );
  runApp(AppInitializer());
}

class AppInitializer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(FirebaseAuth.instance),
        ),
        Provider<FirestoreDatabaseService>(
          create: (_) => FirestoreDatabaseService(FirebaseFirestore.instance),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tapea',
        // Light theme
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: colors.kBackgroundColor,
          fontFamily: 'Montserrat',
          appBarTheme: AppBarTheme.of(context).copyWith(
            backgroundColor: colors.kBackgroundColor,
            elevation: 0,
            titleTextStyle: const TextStyle(
                color: colors.kPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600),
            iconTheme: const IconThemeData(
              color: colors.kPrimaryColor,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(kRedColor),
            ),
          ),
        ),
        themeMode: ThemeMode.light,
        home: AuthListener(
          root: const WelcomeScreen(),
          home: ProfileSetup(),
        ),
        //home: const ProfileSetup(),
        onGenerateRoute: Routes.build,
        // home: const ResponsiveLayout(
        //   desktopLayout: DesktopLayout(),
        //   tabletLayout: TabletLayout(),
        //   mobileLayout: LoginScreen(),
        // )
      ),
    );
  }
}
