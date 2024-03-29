import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/model/field/company_website_field.dart';
import 'package:tapea/model/field/discord_field.dart';
import 'package:tapea/model/field/email_field.dart';
import 'package:tapea/model/field/facebook_field.dart';
import 'package:tapea/model/field/instagram_field.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/link_field_impl.dart';
import 'package:tapea/model/field/linked_in.dart';
import 'package:tapea/model/field/location_field.dart';
import 'package:tapea/model/field/paypal_field.dart';
import 'package:tapea/model/field/phone_number_field.dart';
import 'package:tapea/model/field/phone_number_field_impl.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/model/field/tiktok_field.dart';
import 'package:tapea/model/field/twitch_field.dart';
import 'package:tapea/model/field/twitter_field.dart';
import 'package:tapea/model/field/telegram_field.dart';
import 'package:tapea/model/field/youtube_field.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/screen/profile/components/editor/components/explanation_box.dart';
import 'package:tapea/screen/profile/components/editor/components/field_color_picker.dart';
import 'package:tapea/screen/profile/components/editor/components/field_gridview.dart';
import 'package:tapea/screen/profile/components/editor/components/xmark_button.dart';
import 'package:tapea/service/firestore_datadase_service.dart';
import 'package:tapea/util/text_field_manager.dart';
import 'package:tapea/util/util.dart';
import 'package:tapea/widget/borderless_text_field.dart';
import 'package:tapea/widget/warning_box.dart';

import 'components/editable_field.dart';

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
      final ProfileModel profile = context.read<ProfileNotifier>().profile!;
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
    final ProfileModel profile = context.watch<ProfileNotifier>().profile!;

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
                if (index == 0) ...{
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: FieldColorPicker(
                      onChanged: updateColor,
                    ),
                  )
                },
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
                          onLinkUpdate: updateLink,
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
                  const Padding(
                    padding: const EdgeInsets.all(20),
                    child: ExplanationBox(
                      explanation: 'Tap a field below to add it',
                      icon: FontAwesomeIcons.plus,
                    ),
                  ),
                  FieldGridView(
                    fields: [
                      PhoneNumberFieldImpl(),
                      EmailField(),
                      LinkFieldImpl(),
                      LocationField(),
                      CompanyWebsiteField(),
                      LinkedInField(),
                      PaypalField(),
                      InstagramField(),
                      TwitterField(),
                      FacebookField(),
                      YoutubeField(),
                      DiscordField(),
                      TelegramField(),
                      TikTokField(),
                      TwitchField(),
                    ],
                    onFieldPressed: (field) => Navigator.pushNamed(
                      context,
                      field.route,
                      arguments: markDirty,
                    ),
                  ),
                }
              ],
            );
          },
        )),
      ),
    );
  }

  void updateColor(Color color) {
    context.read<ProfileNotifier>().color = color;
    _dirty = true;
  }

  void updateTitle(String text, int index) {
    final profile = context.read<ProfileNotifier>().profile;
    profile!.fields[index].title = text;
    _dirty = true;
  }

  void updateSubtitle(String text, int index) {
    final profile = context.read<ProfileNotifier>().profile;
    profile!.fields[index].subtitle = text;
    _dirty = true;
  }

  void updatePhoneExt(String text, int index) {
    final profile = context.read<ProfileNotifier>().profile;
    final ProfileField field = profile!.fields[index];
    if (field is PhoneNumberField) {
      field.ext = text;
      _dirty = true;
    }
  }

  void updateLink(String text, int index) {
    final profile = context.read<ProfileNotifier>().profile;
    final ProfileField field = profile!.fields[index];
    if (field is LinkField) {
      field.link = text;
      _dirty = true;
    }
  }

  void removeField(int index) {
    final profile = context.read<ProfileNotifier>().profile;
    profile!.fields.removeAt(index);
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
      await database.setProfile(
        userId: id,
        profile: profile.copyWith(
          title: titleField.text,
          firstName: firstNameField.text,
          lastName: lastNameField.text,
          company: companyField.text,
          color: context.read<ProfileNotifier>().color.value,
          jobTitle: jobTitleField.text,
        ),
      );
    }
  }

  Future<void> saveChanges(ProfileModel profile) async {
    if (_dirty || profile.fields.length != _fieldsLength) {
      await updateDatabase(profile);
      await context
          .read<ProfileNotifier>()
          .update(context: context, index: profile.index);
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
            context.read<ProfileNotifier>().update(
                  context: context,
                  index: profile.index,
                );
          },
          onCancel: () => Navigator.of(context).pop(false),
        );
      },
    );
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
