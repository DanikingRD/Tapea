import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/routes.dart';

class PaypalField extends LinkField {
  PaypalField({
    String title = '',
    String subtitle = '',
    String link = '',
  }) : super(title: title, subtitle: subtitle, link: link);

  @override
  IconData get icon => FontAwesomeIcons.paypal;

  @override
  String get displayName => 'Paypal';

  @override
  ProfileFieldType get type => ProfileFieldType.paypal;
  @override
  String getUrl(String domain) {
    return 'https://www.paypal.me/' + domain.toLowerCase();
  }

  @override
  String get route => Routes.paypalField;
}
