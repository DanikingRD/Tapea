import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/model/card_model.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/widget/borderless_text_field.dart';

class ProfileEditorScreen extends StatefulWidget {
  final bool edit;

  const ProfileEditorScreen({
    Key? key,
    required this.edit,
  }) : super(key: key);

  @override
  State<ProfileEditorScreen> createState() => _ProfileEditorScreenState();
}

class _ProfileEditorScreenState extends State<ProfileEditorScreen> {
  final List<TextFieldEntry> entries = [
    TextFieldEntry(name: 'Profile Title (e.g Work or Personal)'),
    TextFieldEntry(name: 'First Name'),
    TextFieldEntry(name: 'Last Name'),
    TextFieldEntry(name: 'Company'),
    TextFieldEntry(name: 'Job Title')
  ];

  @override
  void initState() {
    super.initState();
    if (widget.edit) {
      collectProfileInfo();
    }
  }

  void collectProfileInfo() {
    final profile = context.read<ProfileNotifier>().profile;
    entries[0].text = profile.title;
    entries[1].text = profile.firstName;
    entries[2].text = profile.lastName;
    entries[3].text = profile.company;
    entries[4].text = profile.jobTitle;
  }

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
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: ((context, index) {
          final TextFieldEntry entry = entries[index];
          const padding = EdgeInsets.symmetric(horizontal: 25, vertical: 0);
          return Padding(
            padding: padding,
            child: BorderlessTextField(
              centerAll: index == 0,
              controller: entry.controller,
              floatingLabel: entry.name,
            ),
          );
        }),
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

  set text(String _text) => controller.text = _text;

  void dispose() {
    controller.dispose();
  }
}
