import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/widgets.dart';
import 'package:tapea/model/profile_model.dart';

class FirebaseDynamicLinkService {
  const FirebaseDynamicLinkService({
    Key? key,
  });

  static Future<String> createDynamicLink(
      {required ProfileModel profile, required bool shortLink}) async {
    final DynamicLinkParameters dynLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://digitalprofile.page.link"),
      uriPrefix: "https://google.com",
      androidParameters: AndroidParameters(
        fallbackUrl: Uri.parse('https://tapea.do'),
        packageName: "com.example.tapea",
        minimumVersion: 30,
      ),
    );

    if (shortLink) {
      var result =
          await FirebaseDynamicLinks.instance.buildShortLink(dynLinkParams);
    }
    return Future(() => '');
  }
}
