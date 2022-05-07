import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/routes.dart';

class QrSenderButton extends StatelessWidget {
  const QrSenderButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, Routes.profileQr),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            context.read<ProfileNotifier>().color,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: const [
              Icon(Icons.send),
              SizedBox(width: 8),
              Text('SEND', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
