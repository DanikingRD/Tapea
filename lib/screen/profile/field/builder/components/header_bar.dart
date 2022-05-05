import 'package:flutter/material.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/field/phone_number_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/widget/circle_icon.dart';

class HeaderBar extends StatelessWidget {
  final IconData icon;
  final ProfileField field;
  final TextEditingController titleController;
  final TextEditingController labelController;
  final TextEditingController? phoneExtController;
  const HeaderBar({
    Key? key,
    required this.icon,
    required this.field,
    required this.titleController,
    required this.labelController,
    required this.phoneExtController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          thickness: 6.0,
          color: kFieldIconScreenDivider,
        ),
        ListTile(
          title: getIconTitle(context),
          leading: CircleIconButton(
            onPressed: null,
            elevation: 1.0,
            icon: Icon(icon),
          ),
          subtitle: getSubtitle(),
        ),
        const Divider(
          thickness: 6.0,
          color: kFieldIconScreenDivider,
        ),
      ],
    );
  }

  Widget getIconTitle(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          titleController.text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (field is PhoneNumberField) ...{
          if (phoneExtController!.text.isNotEmpty) ...{
            Text(
              ' Ext. ' + phoneExtController!.text,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: Colors.grey[600],
              ),
            ),
          }
        }
      ],
    );
  }

  Widget? getSubtitle() {
    return labelController.text.isEmpty
        ? null
        : Text(
            labelController.text,
          );
  }
}
