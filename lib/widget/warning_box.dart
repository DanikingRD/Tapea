import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WarningBox extends StatelessWidget {
  
  final String dialog;
  final String accept;
  final String cancel;
  final Widget? content;
  final Function onAccept;
  final Function? onCancel;

  const WarningBox({
    Key? key,
    required this.dialog,
    this.accept = 'GOT IT',
    this.cancel = 'CANCEL',
    this.content,
    required this.onAccept,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        dialog,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            if (onCancel != null) {
              onCancel!();
            } else {
              Navigator.pop(context);
            }
          },
          child: Text(cancel),
        ),
        TextButton(
          onPressed: () {
            onAccept();
          },
          child: Text(accept),
        ),

      ],
    );
  }
}
