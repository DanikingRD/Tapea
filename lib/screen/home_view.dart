import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/model/user_model.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/provider/user_notifier.dart';
import 'package:tapea/widget/home_navbar.dart';
import 'package:tapea/widget/loading_indicator.dart';

class HomeView extends StatefulWidget {
  final List<Widget> views;

  const HomeView({
    Key? key,
    required this.views,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController();
  late Future<UserModel> userFuture;
  late Future<ProfileModel> profileFuture;
  int _view = 0;

  @override
  void initState() {
    super.initState();
    readAll(context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void readAll(BuildContext context) async {
    userFuture = _readUser(context);
    profileFuture = _readProfile(context);
  }

  Future<UserModel> _readUser(BuildContext context) async {
    final UserNotifier notifier = context.read<UserNotifier>();
    await notifier.update(context);
    return notifier.user;
  }

  Future<ProfileModel> _readProfile(
    BuildContext context,
  ) async {
    final ProfileNotifier notifier = context.read<ProfileNotifier>();
    await notifier.update(context);
    return notifier.profile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kHomeBgColor,
      body: FutureBuilder<List<Object>>(
        future: Future.wait<Object>([
          userFuture,
          profileFuture,
        ]),
        builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
          if (snapshot.hasData) {
            return PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (int page) => setState(() => _view = page),
              children: widget.views,
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(snapshot.error.toString()), // Debugging
                const LoadingIndicator(),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: HomeBottomNavBar(
        icons: const [
          FontAwesomeIcons.user,
          FontAwesomeIcons.addressBook,
          FontAwesomeIcons.qrcode,
        ],
        onTap: (int index) => setView(index),
        currentIndex: _view,
      ),
    );
  }

  void setView(int view) {
    _pageController.jumpToPage(view);
  }
}
