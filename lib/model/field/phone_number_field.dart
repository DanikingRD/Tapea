import 'package:tapea/model/field/profile_field.dart';

abstract class PhoneNumberField extends ProfileField {
  String ext;

  PhoneNumberField({
    String title = '',
    String subtitle = '',
    this.ext = '',
  }) : super(
          title: title,
          subtitle: subtitle,
        );
  set phoneExt(String phoneExtension) => ext = phoneExtension;

  String displayExtension() {
    return 'Ext.' ' ' + ext;
  }
}
