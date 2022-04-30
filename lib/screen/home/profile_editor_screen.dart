import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/service/firestore_datadase_service.dart';
import 'package:tapea/util/field_identifiers.dart';
import 'package:tapea/util/text_field_manager.dart';
import 'package:tapea/util/util.dart';
import 'package:tapea/widget/borderless_text_field.dart';
import 'package:tapea/widget/circle_icon.dart';
import 'package:tapea/widget/warning_box.dart';

class ProfileEditorScreen extends StatefulWidget {
  final bool edit;

  const ProfileEditorScreen({
    Key? key,
    required this.edit,
  }) : super(key: key);

  @override
  State<ProfileEditorScreen> createState() => _ProfileEditorScreenState();
}

class ProfileField {
  final String title;
  final String subtitle;
  final IconData icon;

  const ProfileField({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class _ProfileEditorScreenState extends State<ProfileEditorScreen> {
  final TextFieldManager titleField = TextFieldManager(label: 'Title');
  final TextFieldManager firstNameField = TextFieldManager(label: 'First Name');
  final TextFieldManager lastNameField = TextFieldManager(label: 'Last Name');
  final TextFieldManager companyField = TextFieldManager(label: 'Company');
  final TextFieldManager jobTitleField = TextFieldManager(label: 'Job Title');
  bool _dirty = false;

  static const List<FieldManager> globalFields = [
    FieldManager(
      titleLabel: 'Phone Number',
      type: ProfileFieldType.phoneNumber,
      icon: FontAwesomeIcons.phone,
    ),
  ];

  late List<ProfileField> profileFields;

  @override
  void initState() {
    super.initState();
    if (widget.edit) {
      final ProfileModel profile = context.read<ProfileNotifier>().profile;
      updateControllers(profile);
    }
  }

  List<ProfileField> getProfileFields(ProfileModel profile) {
    final List<ProfileField> fields = [];
    // We iterate over all the global fields and for each one
    // We get how many instances does the user has created.
    for (int i = 0; i < globalFields.length; i++) {
      final manager = globalFields[i];
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

  @override
  void dispose() {
    titleField.dispose();
    firstNameField.dispose();
    lastNameField.dispose();
    companyField.dispose();
    jobTitleField.dispose();
    super.dispose();
  }

  void updateControllers(ProfileModel profile) {
    titleField.update(profile.title);
    firstNameField.update(profile.firstName);
    lastNameField.update(profile.lastName);
    companyField.update(profile.company);
    jobTitleField.update(profile.jobTitle);
  }

  Future<void> updateDatabase(ProfileModel oldProfile) async {
    if (_dirty) {
      final String? id = getIdentifier(context);
      if (id != null) {
        final info = {
          ProfileFieldID.title: titleField.text,
          ProfileFieldID.firstName: firstNameField.text,
          ProfileFieldID.lastName: lastNameField.text,
          ProfileFieldID.company: companyField.text,
          ProfileFieldID.jobTitle: jobTitleField.text,
          ProfileFieldID.photoUrl: oldProfile.photoUrl,
          ProfileFieldID.phoneNumbers: oldProfile.phoneNumbers,
          'labels': {},
        };
        final ProfileModel newProfile = ProfileModel.fromJson(info);
        final db = context.read<FirestoreDatabaseService>();
        await db.setDefaultUserProfile(userId: id, profile: newProfile);
      }
    }
  }

  Future<void> saveChanges(ProfileModel profile) async {
    await updateDatabase(profile);
    await context.read<ProfileNotifier>().update(context);
  }

  @override
  Widget build(BuildContext context) {
    final ProfileModel profile = context.watch<ProfileNotifier>().profile;
    profileFields = getProfileFields(profile);
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
                    onChanged: (String? str) {
                      _dirty = true;
                    }),
              ),
              if (index == 4) ...{
                const SizedBox(
                  height: 20,
                ),
                if (profileFields.isNotEmpty) ...{
                  _explanationBox(
                    explanation: 'Hold each field to re-order it',
                    icon: FontAwesomeIcons.upDown,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ReorderableListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final ProfileField field = profileFields[index];
                      return _editableField(field);
                    },
                    itemCount: profileFields.length,
                    onReorder: (previousIndex, newIndex) {},
                  )
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

  Widget _editableField(ProfileField field) {
    return ListTile(
      key: ValueKey(field),
      leading: CircleIcon(
        iconData: field.icon,
      ),
      title: Text(field.title),
      subtitle: Text(field.subtitle),
      trailing: IconButton(
        splashRadius: kSplashRadius,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return WarningBox(
                dialog: 'Are you sure you want to delete this field?',
                onAccept: () {
                  Navigator.pop(context);
                  deleteField(
                    context: context,
                    text: field.title,
                  );
                },
                accept: 'YES, DELETE FIELD',
              );
            },
          );
        },
        icon: const Icon(
          FontAwesomeIcons.xmark,
          color: Colors.black,
        ),
      ),
    );
  }

  void deleteField({
    required BuildContext context,
    required String text,
  }) async {
    final profile = context.read<ProfileNotifier>().profile;
    profile.phoneNumbers.remove(text);
    setState(() {
      _dirty = true;
    });
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
}
