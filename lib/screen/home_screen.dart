import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tapea/screen/contact/contact_view.dart';
import 'package:tapea/screen/home_view.dart';
import 'package:tapea/screen/profile/profile_view.dart';
import 'package:tapea/screen/settings/settings_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const HomeView(
      views: [
        ProfileView(),
        ContactView(),
        SettingsView(),
      ],
    );
  }
}
