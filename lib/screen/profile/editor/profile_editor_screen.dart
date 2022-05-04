import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/model/field/email_field.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/location_field.dart';
import 'package:tapea/model/field/phone_number_field.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/screen/profile/editor/components/editable_field.dart';
import 'package:tapea/screen/profile/editor/components/explanation_box.dart';
import 'package:tapea/screen/profile/editor/components/field_gridview.dart';
import 'package:tapea/screen/profile/editor/components/xmark_button.dart';
import 'package:tapea/service/firestore_datadase_service.dart';
import 'package:tapea/util/text_field_manager.dart';
import 'package:tapea/util/util.dart';
import 'package:tapea/widget/borderless_text_field.dart';
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
  late int _fieldsLength;
  @override
  void initState() {
    super.initState();
    if (widget.edit) {
      final ProfileModel profile = context.read<ProfileNotifier>().profile;
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
                    },
                  ),
                ),
                if (index == 4) ...{
                  const SizedBox(
                    height: 20,
                  ),
                  if (profile.fields.isNotEmpty) ...{
                    const ExplanationBox(
                      explanation: 'Hold each field to re-order it',
                      icon: FontAwesomeIcons.upDown,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReorderableListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, pos) {
                        final ProfileField field = profile.fields[pos];
                        return EditableField(
                          key: ValueKey(field.title + ' loaded at index $pos'),
                          index: pos,
                          field: field,
                          onTitleUpdate: updateTitle,
                          onSubtitleUpdate: updateSubtitle,
                          onPhoneExtUpdate: updatePhoneExt,
                          trailing: XMarkButton(
                            onAccept: removeField,
                            index: pos,
                          ),
                        );
                      },
                      itemCount: profile.fields.length,
                      onReorder: (previousIndex, newIndex) {
                        setState(() {
                          int _pos = newIndex > previousIndex
                              ? newIndex - 1
                              : newIndex;
                          final field = profile.fields.removeAt(previousIndex);
                          profile.fields.insert(_pos, field);
                          _dirty = true;
                        });
                      },
                    )
                  },
                  const ExplanationBox(
                    explanation: 'Tap a field below to add it',
                    icon: FontAwesomeIcons.plus,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FieldGridView(
                    fields: [
                      PhoneNumberField(),
                      EmailField(),
                      LinkField(),
                      LocationField(),
                    ],
                    onFieldPressed: openScreenByIndex,
                  ),
                }
              ],
            );
          },
        )),
      ),
    );
  }

  void updateTitle(String text, int index) {
    final profile = context.read<ProfileNotifier>().profile;
    profile.fields[index].title = text;
    _dirty = true;
  }

  void updateSubtitle(String text, int index) {
    final profile = context.read<ProfileNotifier>().profile;
    profile.fields[index].subtitle = text;
    _dirty = true;
  }

  void updatePhoneExt(String text, int index) {
    final profile = context.read<ProfileNotifier>().profile;
    final ProfileField field = profile.fields[index];
    if (field is PhoneNumberField) {
      field.phoneExtension = text;
      _dirty = true;
    }
  }

  void removeField(int index) {
    final profile = context.read<ProfileNotifier>().profile;
    profile.fields.removeAt(index);
    markDirty();
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
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WarningBox(
          dialog: 'Are you sure you want to discard your changes?',
          onAccept: () {
            Navigator.of(context).pop(true);
            // sync with database
            context.read<ProfileNotifier>().update(context);
          },
          onCancel: () => Navigator.of(context).pop(false),
        );
      },
    );
  }

  void openScreenByIndex(int index) {
    final String route;
    switch (index) {
      case 0:
        route = Routes.phoneNumberField;
        break;
      case 1:
        route = Routes.emailField;
        break;
      case 2:
        route = Routes.linkField;
        break;
      case 3:
        route = Routes.locationField;
        break;
      default:
        throw ('Tried to access an undefined screen');
    }
    Navigator.pushNamed(context, route, arguments: markDirty);
  }

  void markDirty() {
    setState(() {
      _dirty = true;
    });
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
