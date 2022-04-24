import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/user_model.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/provider/user_notifier.dart';
import 'package:tapea/widget/loading_indicator.dart';

class HomeView extends StatefulWidget {
  final Widget body;
  final Widget footer;

  const HomeView({
    Key? key,
    required this.body,
    required this.footer,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    loadUser(context);
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
          : SafeArea(
              child: widget.body,
            ),
      bottomNavigationBar: widget.footer,
    );
  }
}
