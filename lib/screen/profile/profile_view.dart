import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/field/email_field.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/location_field.dart';
import 'package:tapea/model/field/phone_number_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/routes.dart';
import 'package:url_launcher/url_launcher.dart';

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
              return getField(context: context, field: field, index: index);
            },
          )
        ],
      ),
    );
  }

  Widget getField({
    required BuildContext context,
    required ProfileField field,
    required int index,
  }) {
    final TextStyle style = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeight.bold);
    return ListTile(
      leading: FloatingActionButton(
        heroTag: Text('btn#$index'),
        child: Icon(
          field.icon,
          size: 28,
        ),
        onPressed: () => getActionFor(field),
        backgroundColor: kSelectedPageColor,
        elevation: 3.0,
        focusElevation: 0.0,
        highlightElevation: 0.0,
      ),
      title: field is PhoneNumberField
          ? RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: field.title + ' ',
                    style: style,
                  ),
                  TextSpan(
                    text: field.displayExtension(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : Text(
              field.title,
              style: style,
            ),
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

  void getActionFor(ProfileField field) async {
    if (field is PhoneNumberField) {
      final Uri resource = Uri(
        scheme: 'tel',
        path: field.title,
      );
      await doAction(resource);
    }
    if (field is EmailField) {
      final Uri resource = Uri(
        scheme: 'mailto',
        path: field.title,
      );
      await doAction(resource);
    }
    if (field is LinkField) {
      // TODO: move this to launchUrl
      await launch(
        field.link,
        forceSafariVC: false,
      );
    }
    if (field is LocationField) {}
  }

  Future<void> doAction(Uri resource) async {
    if (await canLaunchUrl(resource)) {
      await launchUrl(resource);
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((entry) =>
            '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}')
        .join('&');
  }
}
