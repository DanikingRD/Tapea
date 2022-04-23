import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapea/service/firebase_auth_service.dart';

String? getIdentifier(BuildContext context) {
  final provider = context.read<FirebaseAuthService>();
  final User? user = provider.user;
  return user!.uid;
}

Future<Uint8List?> pickImage() async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );
  if (result != null) {
    if (kIsWeb) {
      // TODO: MAKE IT WORK ON WEB USING
      // result.files.single.bytes;
    }
    return await File(result.files.single.path!).readAsBytes();
  } else {
    return null;
  }
}

void notify({
  required BuildContext context,
  required String msg,
  Function()? onClose,
  Widget? content,
  bool dismissible = true,
}) {
  showDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (ctx) {
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
                onClose();
              }
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
