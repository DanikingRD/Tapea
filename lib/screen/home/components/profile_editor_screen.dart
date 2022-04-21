import 'dart:html';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileEditorScreen extends StatefulWidget {
  const ProfileEditorScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileEditorScreen> createState() => _ProfileEditorScreenState();
}

class _ProfileEditorScreenState extends State<ProfileEditorScreen> {
  final List<TextFieldEntry> entries = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Card'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(FontAwesomeIcons.check),
          )
        ],
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}

class TextFieldEntry {
  final String name;
  final TextEditingController controller = TextEditingController();
  TextFieldEntry({
    required this.name,
  });

  factory TextFieldEntry.withText(String name, String text) {
    final entry = TextFieldEntry(name: name);
    entry.controller.text = text;
    return entry;
  }

  void dispose() {
    controller.dispose();
  }
}
