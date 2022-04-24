import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/widget/circle_icon.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final ProfileModel profile;

  @override
  void initState() {
    super.initState();
    profile = getProfile();
  }

  ProfileModel getProfile() {
    return context.read<ProfileNotifier>().profile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kHomeBgColor,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              Routes.profileEditor,
              arguments: true,
            ),
            icon: const FaIcon(FontAwesomeIcons.pencil),
          )
        ],
      ),
      backgroundColor: kHomeBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            getMainInfo(),
            ..._getTiles(),
          ],
        ),
      ),
    );
  }

  List<Widget> _getTiles() {
    return [
      _tile(
        title: '8494069669',
        icon: FontAwesomeIcons.phone,
        onPressed: () {},
      ),
    ];
  }

  Widget _tile({
    required IconData icon,
    required Function() onPressed,
    required String title,
  }) {
    return ListTile(
      leading: CircleIconButton(
        circleSize: 54,
        icon: Icon(
          icon,
          size: 24,
        ),
        onPressed: onPressed,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: const Text('Mobile'),
    );
  }

  Widget getMainInfo() {
    return ListTile(
      title: Text(
        profile.firstName + profile.lastName,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: profile.jobTitle + "\n",
              style: Theme.of(context).textTheme.headline6,
            ),
            TextSpan(
              text: profile.company,
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
      ),
      isThreeLine: true,
    );
  }

  Widget buildProfileItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: ClipOval(
        child: Container(
          height: 40,
          width: 40,
          color: kRedColor,
          child: Icon(icon),
        ),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }
}
