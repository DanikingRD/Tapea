import 'package:flutter/src/widgets/icon_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/routes.dart';

class LinkFieldImpl extends LinkField {
  LinkFieldImpl({
    String link = '',
    String title = '',
    String subtitle = '',
  }) : super(link: link, title: title, subtitle: subtitle);

  @override
  String getUrl(String domain) {
    return 'https://www.' + domain.toLowerCase() + '.com';
  }

  @override
  IconData get icon => FontAwesomeIcons.link;

  @override
  String get route => Routes.linkField;

  @override
  ProfileFieldType get type => ProfileFieldType.link;

  @override
  String get displayName => 'Link';
}
