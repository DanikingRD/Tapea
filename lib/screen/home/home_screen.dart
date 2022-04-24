import 'package:flutter/material.dart';
import 'package:tapea/screen/home/view/home_view.dart';
import 'package:tapea/screen/home/view/profile_view.dart';
import 'package:tapea/screen/home/view/share_profile_view.dart';

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
        Text('CONTACTS'),
        ShareProfileView(),
      ],
    );
  }
}
