import 'package:flutter/material.dart';

class NotificationBox extends StatelessWidget {
  final String msg;
  final VoidCallback? onClose;
  final Widget? content;
  const NotificationBox({
    Key? key,
    required this.msg,
    this.onClose,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        msg,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (onClose != null) {
              onClose!();
            }
          },
          child: const Text('GOT IT'),
        ),
      ],
    );
  }
}
