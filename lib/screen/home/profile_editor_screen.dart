import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/service/firestore_datadase_service.dart';
import 'package:tapea/util/util.dart';
import 'package:tapea/widget/borderless_text_field.dart';
import 'package:tapea/widget/circle_icon.dart';

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
  final List<_TextFieldEntry> entries = [
    _TextFieldEntry(label: 'Title', field: ProfileFieldType.title),
    _TextFieldEntry(label: 'First Name', field: ProfileFieldType.firstName),
    _TextFieldEntry(label: 'Last Name', field: ProfileFieldType.lastName),
    _TextFieldEntry(label: 'Company', field: ProfileFieldType.company),
    _TextFieldEntry(label: 'Job Title', field: ProfileFieldType.jobTitle)
  ];
  static final Map<String, IconData> icons = {
    ProfileFieldType.phoneNumber.id: FontAwesomeIcons.phone,
  };

  final List<_TextFieldEntry> optionalFields = [
    _TextFieldEntry(
      label: 'Enter your phone number',
      field: ProfileFieldType.phoneNumber,
      hasOptionalLabel: true,
      optionalController: TextEditingController(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.edit) {
      collectProfileInfo();
    }
  }

  void collectProfileInfo() {
    final ProfileModel profile = context.read<ProfileNotifier>().profile;
    entries[0].text = profile.title;
    entries[1].text = profile.firstName;
    entries[2].text = profile.lastName;
    entries[3].text = profile.company;
    entries[4].text = profile.jobTitle;
  }

  Future<void> updateProfile(ProfileModel profile) async {
    final String? id = getIdentifier(context);
    if (id != null) {
      for (int i = 0; i < entries.length; i++) {
        final _TextFieldEntry entry = entries[i];
        final String text = entry.innerText;
        final ProfileFieldType field = entry.field;
        final Map<String, String> checkList = {};
        final Object? storedData = profile.getFieldByType(field);
        if (storedData is String) {
          checkList[field.id] = text;
        }
        if (checkList.isNotEmpty) {
          final database = context.read<FirestoreDatabaseService>();
          await database.updateDefaultProfile(
            userId: id,
            data: checkList,
          );
        }
      }
    }
  }

  Future<void> saveChanges(ProfileModel profile) async {
    await updateProfile(profile);
    await context.read<ProfileNotifier>().update(context);
  }

  @override
  Widget build(BuildContext context) {
    final ProfileModel profile = context.watch<ProfileNotifier>().profile;
    final List<Widget> tiles = _editableTiles(profile);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Card'),
        actions: [
          IconButton(
            onPressed: () async {
              await saveChanges(profile);
              Navigator.pop(context);
            },
            icon: const FaIcon(FontAwesomeIcons.check),
          )
        ],
      ),
      body: ListView(
          children: List.generate(
        entries.length,
        (index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 2.0,
                ),
                child: BorderlessTextField(
                  centerAll: index == 0,
                  controller: entries[index].controller,
                  floatingLabel: entries[index].label,
                ),
              ),
              if (index == entries.length - 1) ...{
                const SizedBox(
                  height: 20,
                ),
                if (tiles.isNotEmpty) ...{
                  _explanationBox(
                    explanation: 'Hold each field to re-order it',
                    icon: FontAwesomeIcons.upDown,
                  ),
                  ...tiles,
                  const SizedBox(
                    height: 20,
                  ),
                },
                _explanationBox(
                  explanation: 'Tap a field below to add it',
                  icon: FontAwesomeIcons.plus,
                ),
                const SizedBox(
                  height: 10,
                ),
                getFields(context)
              }
            ],
          );
        },
      )),
    );
  }

  List<Widget> _editableTiles(ProfileModel profile) {
    final List<Widget> _tiles = [];
    // We iterate over all available fields
    for (int i = 0; i < optionalFields.length; i++) {
      final _TextFieldEntry entry = optionalFields[i];
      final Object? field = profile.getFieldByType(entry.field);
      // If this is true, the user has already initialized the tile
      if (field != null) {
        final IconData? icon = icons[entry.field.id];
        // This shouldn't be null, but who knows.
        if (icon != null) {
          entry.controller.text = profile.fields[entry.field.id];
          if (entry.hasOptionalLabel) {
            entry.optionalController!.text = profile.labels[entry.field.id];
          }
          _tiles.add(
            _editableField(
              icon: icon,
              titleLabel: entry.label,
              titleController: entry.controller,
              labelController: entry.optionalController,
              hasLabel: entry.hasOptionalLabel,
            ),
          );
        }
      }
    }
    return _tiles;
  }

  Widget _editableField({
    required IconData icon,
    required String titleLabel,
    required TextEditingController titleController,
    TextEditingController? labelController,
    bool hasLabel = false,
  }) {
    return ListTile(
      //trailing: Text('dasd'),
      minVerticalPadding: 0,
      leading: Column(
        children: const [
          SizedBox(
            height: 8,
          ),
          CircleIcon(
            backgroundColor: kSelectedPageColor,
            iconData: FontAwesomeIcons.phone,
          ),
        ],
      ),
      title: BorderlessTextField(
        controller: titleController,
        floatingLabel: titleLabel,
      ),
      subtitle: hasLabel
          ? BorderlessTextField(
              controller: labelController,
              floatingLabel: 'Label (Optional)',
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _explanationBox({
    required String explanation,
    IconData? icon,
  }) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Card(
          color: Colors.grey.shade200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                explanation,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (icon != null) ...{
                Icon(icon),
              }
            ],
          ),
        ),
      ),
    );
  }

  void selectIcon(BuildContext context, IconData profileIcon) {
    final String route;
    if (profileIcon == FontAwesomeIcons.phone) {
      route = Routes.addPhoneField;
    } else {
      throw ('aosdaa');
    }
    Navigator.pushNamed(context, route);
  }

  Widget getFields(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<IconData> icons = [
      FontAwesomeIcons.phone,
      Icons.email,
      FontAwesomeIcons.youtube,
    ];

    return Container(
      width: size.width,
      height: size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: kProfileEditorFieldContainer,
      ),
      child: GridView.count(
        crossAxisSpacing: 50,
        crossAxisCount: 3,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        children: List.generate(3, (index) {
          return CircleIconButton(
            onPressed: () => selectIcon(context, icons[index]),
            icon: Icon(
              icons[index],
              color: Colors.white,
            ),
          );
        }),
      ),
    );
  }
}

class _TextFieldEntry {
  final String label;
  final ProfileFieldType field;
  final TextEditingController controller = TextEditingController();
  final TextEditingController? optionalController;
  bool hasOptionalLabel = false;
  _TextFieldEntry({
    required this.label,
    required this.field,
    this.hasOptionalLabel = false,
    this.optionalController,
  });
  set text(String _text) => controller.text = _text;
  get innerText => controller.text;

  void dispose() {
    controller.dispose();
  }
}
