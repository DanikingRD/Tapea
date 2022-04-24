import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
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
  int _view = 0;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    loadUser(context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void loadUser(BuildContext context) async {
    setState(() => _loading = true);
    final UserModel user = await readUser(context);
    await readProfile(context, user.defaultProfile);
    setState(() => _loading = false);
  }

  Future<UserModel> readUser(BuildContext context) async {
    final UserNotifier notifier = context.read<UserNotifier>();
    await notifier.update(context);
    return notifier.user;
  }

  Future<void> readProfile(BuildContext context, String profileTitle) async {
    final ProfileNotifier notifier = context.read<ProfileNotifier>();
    await notifier.update(context, profileTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kHomeBgColor,
      body: _loading
          ? const LoadingIndicator()
          : PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (int page) => setState(() => _view = page),
              children: widget.views,
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
