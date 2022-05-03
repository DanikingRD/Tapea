import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/widget/warning_box.dart';

class XMarkButton extends StatelessWidget {
  final void Function(int index) onAccept;
  final int index;

  const XMarkButton({
    Key? key,
    required this.onAccept,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return WarningBox(
            dialog: 'Are you sure you want to delete this field?',
            onAccept: () {
              Navigator.pop(ctx);
              onAccept(index);
            },
            accept: 'YES, DELETE FIELD',
          );
        },
      ),
      icon: const Icon(
        FontAwesomeIcons.xmark,
        color: Colors.black,
      ),
    );
  }
}
