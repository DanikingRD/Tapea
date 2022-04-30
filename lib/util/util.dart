import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/profile_field.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/service/firebase_auth_service.dart';
import 'package:tapea/util/field_identifiers.dart';
import 'package:tapea/widget/loading_indicator.dart';

List<ProfileField> findProfileFields(ProfileModel profile) {
  final List<ProfileField> fields = [];
  // We iterate over all the global fields and for each one
  // We get how many instances does the user has created.
  for (int i = 0; i < kGlobalProfileFields.length; i++) {
    final manager = kGlobalProfileFields[i];
    final Map<String, List<dynamic>> mapList = profile.mapFields();
    final List<dynamic> data = mapList[manager.type.id]!;
    if (data.isNotEmpty) {
      // Iteration over all the fields of a certain type.
      for (int j = 0; j < data.length; j++) {
        final String text = data[j];
        final ProfileField field = ProfileField(
          title: text,
          subtitle: 'subtitle',
          icon: manager.icon,
        );
        fields.add(field);
      }
    }
  }
  return fields;
}

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
