import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/screen/profile/components/qr/components/qr_card.dart';
import 'package:tapea/service/firebase_dynamic_link_service.dart';
import 'package:tapea/util/util.dart';

class ProfileQrScreen extends StatelessWidget {
  const ProfileQrScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<ProfileNotifier>();
    final Color foregroundColor = useWhiteForeground(
      notifier.color,
    )
        ? Colors.white
        : Colors.black;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Send Profile',
          style: TextStyle(
            color: foregroundColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: notifier.color,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: FaIcon(
            FontAwesomeIcons.xmark,
            color: foregroundColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: QrImage(
                  data: '12345',
                  version: QrVersions.auto,
                  size: 300,
                  padding: const EdgeInsets.all(20),
                  semanticsLabel: 'Profile Qr code',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Point your camera at the QR code to receive the profile!',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: foregroundColor,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            QrCard(
              title: 'Copy Link',
              icon: Icons.copy,
              onClick: () async {
                final String? id = getIdentifier(context);
                if (id != null) {
                  await getLink(id, notifier.profile!);
                }
              },
            ),
            QrCard(
              title: 'Send QR code',
              icon: Icons.send,
              onClick: () {},
            ),
          ],
        ),
      ),
      backgroundColor: notifier.color,
    );
  }

  Future<void> getLink(String uid, ProfileModel profile) async {
    // Deep link implementation
    String generatedLink = await FirebaseDynamicLinkService.createDynamicLink(
      uid,
      profile.index.toString(),
    );
    print('generated link: $generatedLink');
  }
}
