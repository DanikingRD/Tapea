import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/service/firebase_auth_service.dart';
import 'package:tapea/widget/loading_indicator.dart';
import 'package:tapea/widget/notification_box.dart';

String? getIdentifier(BuildContext context) {
  final provider = context.read<FirebaseAuthService>();
  final User? user = provider.user;
  if (user == null) return null;
  return user.uid;
}

Future<Uint8List?> pickImage() async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );
  if (result != null) {
    if (kIsWeb) {
      return Future(() => result.files.single.bytes);
    } else {
      return await File(result.files.single.path!).readAsBytes();
    }
  } else {
    return null;
  }
}

void showWarning({
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

void notify({
  required String msg,
  required BuildContext context,
  VoidCallback? onClose,
  Widget? content,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return NotificationBox(
        msg: msg,
        onClose: onClose,
        content: content,
      );
    },
  );
}

void showLoadingBox({
  required BuildContext context,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          width: 125,
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: kProgressIndicatorBox,
          ),
          child: const LoadingIndicator(),
        ),
      );
    },
  );
}
