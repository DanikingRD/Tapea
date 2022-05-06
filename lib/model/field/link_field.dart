import 'package:tapea/model/field/profile_field.dart';

abstract class LinkField extends ProfileField {
  String link;
  LinkField({
    String title = '',
    String subtitle = '',
    this.link = '',
  }) : super(
          title: title,
          subtitle: subtitle,
        );

  String getUrl(String domain);

  void setLink(String link) {
    this.link = link;
  }
}
