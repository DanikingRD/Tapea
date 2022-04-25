import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/provider/user_notifier.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/screen/home/profile/add_phone_number_screen.dart';
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
    _TextFieldEntry(label: 'Title', field: ProfileTextFieldType.title),
    _TextFieldEntry(label: 'First Name', field: ProfileTextFieldType.firstName),
    _TextFieldEntry(label: 'Last Name', field: ProfileTextFieldType.lastName),
    _TextFieldEntry(label: 'Company', field: ProfileTextFieldType.company),
    _TextFieldEntry(label: 'Job Title', field: ProfileTextFieldType.jobTitle)
  ];
  final Map<IconData, Widget> items = {
    FontAwesomeIcons.phone: const PhoneNumberScreen()
  };

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

  Future<void> updateProfile() async {
    final String? id = getIdentifier(context);
    if (id != null) {
      final profileNotifier = context.read<ProfileNotifier>();
      final profile = profileNotifier.profile;
      for (int i = 0; i < entries.length; i++) {
        final _TextFieldEntry entry = entries[i];
        final String text = entry.innerText;
        final ProfileTextFieldType field = entry.field;
        final Map<String, String> checkList = {};
        final Object? storedData = profile.getFieldByType(field);
        if (storedData is String) {
          checkList[field.id] = text;
        }
        if (checkList.isNotEmpty) {
          final user = context.read<UserNotifier>().user;
          final database = context.read<FirestoreDatabaseService>();
          await database.updateProfile(
            userId: id,
            title: user.defaultProfile,
            data: checkList,
          );
          // final profileTitle = ProfileTextField.title.id;
          // if (checkList.containsKey(profileTitle)) {
          //   print('UPDATING USER');
          //   await database.updateUser(
          //     userId: id,
          //     data: {
          //       profileTitle: checkList[profileTitle],
          //     },
          //   );
          // }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Card'),
        actions: [
          IconButton(
            onPressed: () async {
              await updateProfile();
              Navigator.pop(context);
              String profile = context.read<UserNotifier>().user.defaultProfile;
              await context.read<ProfileNotifier>().update(context, profile);
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
                  height: 40,
                ),
                explanationBox('Tap a field below to add it'),
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

  Widget explanationBox(String name) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Card(
          color: Colors.grey.shade200,
          child: Center(
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
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
  final ProfileTextFieldType field;
  final TextEditingController controller = TextEditingController();
  _TextFieldEntry({
    required this.label,
    required this.field,
  });
  set text(String _text) => controller.text = _text;
  get innerText => controller.text;

  void dispose() {
    controller.dispose();
  }
}
