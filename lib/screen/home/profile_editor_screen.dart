import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/service/firestore_datadase_service.dart';
import 'package:tapea/util/text_field_manager.dart';
import 'package:tapea/util/util.dart';
import 'package:tapea/widget/borderless_text_field.dart';
import 'package:tapea/widget/circle_icon.dart';
import 'package:tapea/widget/loading_indicator.dart';

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
  final TextFieldManager titleField = TextFieldManager(label: 'Title');
  final TextFieldManager firstNameField = TextFieldManager(label: 'First Name');
  final TextFieldManager lastNameField = TextFieldManager(label: 'Last Name');
  final TextFieldManager companyField = TextFieldManager(label: 'Company');
  final TextFieldManager jobTitleField = TextFieldManager(label: 'Job Title');
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
      updateControllers();
    }
  }

  @override
  void dispose() {
    titleField.dispose();
    firstNameField.dispose();
    lastNameField.dispose();
    companyField.dispose();
    jobTitleField.dispose();
    super.dispose();
  }

  void updateControllers() {
    final ProfileModel profile = context.read<ProfileNotifier>().profile;
    titleField.update(profile.title);
    firstNameField.update(profile.firstName);
    lastNameField.update(profile.lastName);
    companyField.update(profile.company);
    jobTitleField.update(profile.jobTitle);
  }

  Future<void> updateProfile(ProfileModel oldProfile) async {
    final String? id = getIdentifier(context);
    if (id != null) {
      final Map<String, dynamic> changes = {};
      if (titleField.text != oldProfile.title) {
        changes['title'] = titleField.text;
      }
      if (firstNameField.text != oldProfile.firstName) {
        changes['firstName'] = firstNameField.text;
      }
      if (lastNameField.text != oldProfile.lastName) {
        changes['lastName'] = lastNameField.text;
      }
      if (companyField.text != oldProfile.company) {
        changes['company'] = companyField.text;
      }
      if (jobTitleField.text != oldProfile.jobTitle) {
        changes['jobTitle'] = jobTitleField.text;
      }
      if (changes.isNotEmpty) {
        final db = context.read<FirestoreDatabaseService>();
        await db.updateDefaultProfile(
          userId: id,
          data: changes,
        );
      }
    }
  }

  Future<void> saveChanges(ProfileModel profile) async {
    await updateProfile(profile);
    await context.read<ProfileNotifier>().update(context);
  }

  TextEditingController getControllers(int index) {
    switch (index) {
      case 0:
        return titleField.controller;
      case 1:
        return firstNameField.controller;
      case 2:
        return lastNameField.controller;
      case 3:
        return companyField.controller;
      case 4:
        return jobTitleField.controller;
      default:
        throw ('Tried to access an undefined text field');
    }
  }

  String getLabels(int index) {
    switch (index) {
      case 0:
        return titleField.label;
      case 1:
        return firstNameField.label;
      case 2:
        return lastNameField.label;
      case 3:
        return companyField.label;
      case 4:
        return jobTitleField.label;
      default:
        throw ('Tried to access an undefined text field');
    }
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
              showLoadingBox(context: context);
              await saveChanges(profile);
              // Pop off to home screen
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: const FaIcon(FontAwesomeIcons.check),
          )
        ],
      ),
      body: ListView(
          children: List.generate(
        5, // Text fields
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
                  controller: getControllers(index),
                  floatingLabel: getLabels(index),
                ),
              ),
              if (index == 4) ...{
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
