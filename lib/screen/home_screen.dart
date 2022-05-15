import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:tapea/screen/contact/contact_view.dart';
import 'package:tapea/screen/home_view.dart';
import 'package:tapea/screen/profile/profile_view.dart';
import 'package:tapea/screen/settings/settings_view.dart';
import 'package:tapea/service/firebase_dynamic_link_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseDynamicLinkService.initDynamicLinks();
  }

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
