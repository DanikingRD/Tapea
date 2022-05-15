import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/widgets.dart';
import 'package:tapea/constants.dart';

class FirebaseDynamicLinkService {
  FirebaseDynamicLinkService({
    Key? key,
  });

  static void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynLink) async {
      if (dynLink != null) {
        _handleLink(dynLink.link);
      }
    }, onError: (OnLinkErrorException exception) async {
      print('dyn link error: ${exception.message}');
    });
  }

  static void _handleLink(Uri deeplink) {
    final List<String> links = [];
    links.addAll(deeplink.path.split('/'));
    print('Handling links: ' + links.toString());
  }

  static Future<String> createDynamicLink(
    String id,
    String profileId,
  ) async {
    final DynamicLinkParameters params = DynamicLinkParameters(
      uriPrefix: kAppLink,
      link: Uri.parse('$kAppLink/$id'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.tapea',
        minimumVersion: 0,
      ),
    );
    final link = await params.buildShortLink();
    return link.shortUrl.toString();
  }
}
