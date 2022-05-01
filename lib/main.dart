import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tapea/auth_listener.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/firebase_options.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/provider/user_notifier.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/screen/auth/login_screen.dart';
import 'package:tapea/screen/home_screen.dart';
import 'package:tapea/service/firebase_auth_service.dart';
import 'package:tapea/service/firebase_storage_service.dart';
import 'package:tapea/service/firestore_datadase_service.dart';
import 'package:tapea/util/colors.dart' as colors;
import 'package:tapea/util/glowless_scroll_behaviour.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        // Android
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent),
  );
  runApp(const AppInitializer());
}

class AppInitializer extends StatelessWidget {
  const AppInitializer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(FirebaseAuth.instance),
        ),
        Provider<FirestoreDatabaseService>(
          create: (_) => FirestoreDatabaseService(FirebaseFirestore.instance),
        ),
        Provider<FirebaseStorageService>(
          create: (_) => FirebaseStorageService(FirebaseStorage.instance),
        ),
        ChangeNotifierProvider<UserNotifier>(
          create: (_) => UserNotifier(),
        ),
        ChangeNotifierProvider<ProfileNotifier>(
          create: (_) => ProfileNotifier(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tapea',
        scrollBehavior: const GlowlessScrollBehaviour(),
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
              fontWeight: FontWeight.w600,
            ),
            iconTheme: const IconThemeData(
              color: kRedColor,
            ),
          ),
          primarySwatch: Colors.red,
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(kRedColor),
            ),
          ),
        ),
        themeMode: ThemeMode.light,
        home: const AuthListener(
          root: LoginScreen(),
          home: HomeScreen(),
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
