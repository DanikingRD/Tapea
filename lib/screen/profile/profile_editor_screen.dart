import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/field/phone_number_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/service/firestore_datadase_service.dart';
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

class _ProfileEditorScreenState extends State<ProfileEditorScreen> {
  final TextFieldManager titleField = TextFieldManager(label: 'Title');
  final TextFieldManager firstNameField = TextFieldManager(label: 'First Name');
  final TextFieldManager lastNameField = TextFieldManager(label: 'Last Name');
  final TextFieldManager companyField = TextFieldManager(label: 'Company');
  final TextFieldManager jobTitleField = TextFieldManager(label: 'Job Title');
  bool _dirty = false;
  late final ProfileModel oldProfile;
  late int _fieldsLength;
  @override
  void initState() {
    super.initState();
    if (widget.edit) {
      final ProfileModel profile = context.read<ProfileNotifier>().profile;
      oldProfile = profile;
      updateControllers(profile);
      _fieldsLength = profile.fields.length;
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

  void updateControllers(ProfileModel profile) {
    titleField.update(profile.title);
    firstNameField.update(profile.firstName);
    lastNameField.update(profile.lastName);
    companyField.update(profile.company);
    jobTitleField.update(profile.jobTitle);
  }

  Future<void> updateDatabase(ProfileModel profile) async {
    final String? id = getIdentifier(context);
    if (id != null) {
      final database = context.read<FirestoreDatabaseService>();
      await database.setDefaultUserProfile(
        userId: id,
        profile: profile.copyWith(
          title: titleField.text,
          firstName: firstNameField.text,
          lastName: lastNameField.text,
          company: companyField.text,
          jobTitle: jobTitleField.text,
        ),
      );
    }
  }

  Future<void> saveChanges(ProfileModel profile) async {
    if (_dirty || profile.fields.length != _fieldsLength) {
      await updateDatabase(profile);
      await context.read<ProfileNotifier>().update(context);
    }
  }

  Future<bool> onPop(ProfileModel profile) async {
    if (!_dirty && _fieldsLength == profile.fields.length) {
      return Future.value(true);
    }
    return await showDialog(
      context: context,
      builder: (context) {
        return WarningBox(
          dialog: 'Are you sure you want to discard your changes?',
          onAccept: () {
            Navigator.of(context).pop(true);
          },
          onCancel: () => Navigator.of(context).pop(false),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ProfileModel profile = context.watch<ProfileNotifier>().profile;
    return WillPopScope(
      onWillPop: () async => await onPop(profile),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Card'),
          centerTitle: true,
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
                  if (profile.fields.isNotEmpty) ...{
                    _explanationBox(
                      explanation: 'Hold each field to re-order it',
                      icon: FontAwesomeIcons.upDown,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReorderableListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final ProfileField field = profile.fields[index];
                        return _editableField(
                          field: field,
                          index: index,
                          profile: profile,
                        );
                      },
                      itemCount: profile.fields.length,
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
      ),
    );
  }

  Widget _editableField({
    required ProfileField field,
    required int index,
    required ProfileModel profile,
  }) {
    return ListTile(
      key: ValueKey(field),
      leading: CircleIconButton(
        onPressed: null,
        elevation: 1.0,
        icon: Icon(field.icon),
      ),
      title: BorderlessTextField(
        initialValue: field.title,
        floatingLabel: field.floatingLabel,
        onChanged: (String? text) {
          profile.fields[index].title = text!;
          _dirty = true;
        },
      ),
      subtitle: Column(
        children: [
          if (field is PhoneNumberField) ...{
            BorderlessTextField(
              initialValue: field.phoneExtension,
              floatingLabel: 'Ext.',
              onChanged: (String? text) {
                profile.fields[index].subtitle = text!;
                _dirty = true;
              },
            ),
          },
          BorderlessTextField(
            initialValue: field.subtitle,
            floatingLabel: 'Label (optional)',
            onChanged: (String? text) {
              profile.fields[index].subtitle = text!;
              _dirty = true;
            },
          ),
        ],
      ),
      trailing: getDeleteFieldButton(profile: profile, index: index),
    );
  }

  Widget getDeleteFieldButton({
    required ProfileModel profile,
    required int index,
  }) {
    return IconButton(
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
                  profile: profile,
                  context: context,
                  index: index,
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
    );
  }

  void deleteField({
    required BuildContext context,
    required ProfileModel profile,
    required int index,
  }) async {
    setState(() {
      profile.fields.removeAt(index);
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

  void openScreenByIndex(BuildContext context, int index) {
    final String route;
    if (index == 0) {
      route = Routes.phoneNumberField;
    } else if (index == 1) {
      route = Routes.emailField;
    } else if (index == 2) {
      route = Routes.linkField;
    } else {
      throw ('Tried to access an unregistered screen');
    }
    Navigator.pushNamed(context, route);
  }

  Widget getFields(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<IconData> icons = [
      FontAwesomeIcons.phone,
      Icons.email,
      FontAwesomeIcons.link
    ];
    return Container(
      width: size.width,
      height: size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: kProfileEditorFieldContainer,
      ),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 50,
        crossAxisCount: 3,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        children: List.generate(3, (index) {
          return CircleIconButton(
            heroTag: Text('btn#$index'),
            onPressed: () => openScreenByIndex(context, index),
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
