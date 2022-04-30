import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/profile_field.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/util/field_identifiers.dart';
import 'package:tapea/util/util.dart';
import 'package:tapea/widget/circle_icon.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late List<ProfileField> profileFields;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProfileModel profile = context.watch<ProfileNotifier>().profile;
    profileFields = findProfileFields(profile);
    return Scaffold(
        appBar: AppBar(
          title: Text(profile.title),
          centerTitle: true,
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
        body: ListView(
          children: [
            getMainInfo(profile),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: profileFields.length,
              itemBuilder: (BuildContext context, int index) {
                final ProfileField field = profileFields[index];
                return _tile(
                  icon: field.icon,
                  onPressed: () {},
                  title: field.title,
                );
              },
            )
          ],
        ));
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

  Widget getMainInfo(ProfileModel profile) {
    return ListTile(
      title: Text(
        profile.firstName + ' ' + profile.lastName,
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
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextSpan(
              text: profile.company,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      isThreeLine: true,
    );
  }
}
