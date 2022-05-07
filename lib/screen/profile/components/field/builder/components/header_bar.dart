import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/field/phone_number_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/widget/circle_icon.dart';

class HeaderBar extends StatelessWidget {
  final IconData icon;
  final ProfileField field;
  final TextEditingController titleController;
  final TextEditingController labelController;
  final TextEditingController? phoneExtController;
  final String? code;
  const HeaderBar({
    Key? key,
    required this.icon,
    required this.field,
    required this.titleController,
    required this.labelController,
    required this.phoneExtController,
    required this.code,
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
            circleColor: context.read<ProfileNotifier>().color,
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
        Expanded(
          child: Text(
            code ?? '' + titleController.text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        if (field is PhoneNumberField) ...{
          if (phoneExtController!.text.isNotEmpty) ...{
            Expanded(
              child: Text(
                ' Ext. ' + phoneExtController!.text,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            )
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
