import 'package:flutter/material.dart';
import 'package:tapea/model/field/phone_number_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/widget/borderless_text_field.dart';
import 'package:tapea/widget/circle_icon.dart';

class EditableField extends StatelessWidget {
  final ProfileField field;
  final int index;
  final Function(String text, int index) onTitleUpdate;
  final Function(String text, int index) onSubtitleUpdate;
  final Function(String text, int index)? onPhoneExtUpdate;
  final Widget? trailing;

  const EditableField({
    Key? key,
    required this.index,
    required this.field,
    required this.onTitleUpdate,
    required this.onSubtitleUpdate,
    this.onPhoneExtUpdate,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleIconButton(
        onPressed: null,
        elevation: 1.0,
        icon: Icon(field.icon),
      ),
      title: BorderlessTextField(
        initialValue: field.title,
        floatingLabel: field.displayName,
        onChanged: (String? text) => onTitleUpdate(text!, index),
      ),
      subtitle: Column(
        children: [
          if (field is PhoneNumberField) ...{
            BorderlessTextField(
              initialValue: (field as PhoneNumberField).phoneExtension,
              floatingLabel: 'Ext.',
              onChanged: (String? text) {
                if (onPhoneExtUpdate != null) onPhoneExtUpdate!(text!, index);
              },
            ),
          },
          BorderlessTextField(
            initialValue: field.subtitle,
            floatingLabel: 'Label (optional)',
            onChanged: (String? text) => onSubtitleUpdate(text!, index),
          ),
        ],
      ),
      trailing: trailing,
    );
  }
}
