import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/field/phone_number_field.dart';
import 'package:tapea/field/profile_field.dart';
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
  @override
  Widget build(BuildContext context) {
    final ProfileModel profile = context.watch<ProfileNotifier>().profile;
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
            itemCount: profile.fields.length,
            itemBuilder: (BuildContext context, int index) {
              final ProfileField field = profile.fields[index];
              return _tile(
                context: context,
                field: field,
                onPressed: () {},
              );
            },
          )
        ],
      ),
    );
  }

  Widget _tile({
    required BuildContext context,
    required ProfileField field,
    required Function() onPressed,
  }) {
    return ListTile(
      leading: CircleIconButton(
        circleSize: 48,
        icon: Icon(
          field.icon,
          size: 20,
        ),
        onPressed: onPressed,
      ),
      title: field is PhoneNumberField
          ? RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: field.title + ' ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: field.displayExtensionOnly(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : Text(field.title),
      subtitle: field.subtitle.isNotEmpty ? Text(field.subtitle) : null,
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
