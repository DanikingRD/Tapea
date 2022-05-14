import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/firebase_options.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/provider/user_notifier.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/service/firebase_auth_service.dart';
import 'package:tapea/service/firebase_storage_service.dart';
import 'package:tapea/service/firestore_datadase_service.dart';
import 'package:tapea/user_initializer.dart';
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
  final service = FirebaseAuthService(FirebaseAuth.instance);
  runApp(
    MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => service,
        ),
        StreamProvider<User?>(
          create: (_) => service.authStateChanges,
          initialData: null,
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
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            fontFamily: 'Montserrat',
            fontSize: 20,
            color: colors.kPrimaryColor,
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
      home: const UserInitializer(),
      onGenerateRoute: Routes.build,
    );
  }
}
