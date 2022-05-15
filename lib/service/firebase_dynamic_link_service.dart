import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/widgets.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/profile_model.dart';

class FirebaseDynamicLinkService {
  FirebaseDynamicLinkService({
    Key? key,
  });

  static Future<String> createDynamicLink(bool short, String link) async {
    final dynLinkInstance = FirebaseDynamicLinks.instance;
    final DynamicLinkParameters params = DynamicLinkParameters(
      link: Uri.parse(kAppLink + link),
      uriPrefix: kAppLink,
      androidParameters: const AndroidParameters(
        packageName: 'com.example.tapea',
      ),
    );
    if (short) {
      final ShortDynamicLink shortLink = await dynLinkInstance.buildShortLink(
        params,
      );
      return shortLink.shortUrl.toString();
    } else {
      final Uri uri = await dynLinkInstance.buildLink(params);
      return uri.toString();
    }
  }
}
