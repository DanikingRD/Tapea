import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/profile_model.dart';
import 'package:tapea/model/user_model.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/screen/auth/default_profile/components/default_profile_avatar.dart';
import 'package:tapea/service/firebase_auth_service.dart';
import 'package:tapea/service/firebase_storage_service.dart';
import 'package:tapea/service/firestore_datadase_service.dart';
import 'package:tapea/util/responsive.dart';
import 'package:tapea/util/util.dart';
import 'package:tapea/widget/auth_button.dart';
import 'package:tapea/widget/auth_text_field.dart';

class ProfileSetup extends StatefulWidget {
  const ProfileSetup({Key? key}) : super(key: key);

  @override
  State<ProfileSetup> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  final TextEditingController _profileTitle = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  Uint8List? _selectedImage;
  bool _loading = false;

  @override
  void dispose() {
    _profileTitle.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _jobController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextStyle textStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.bold,
        );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create your first profile'),
        centerTitle: true,
      ),
      body: Responsive(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultProfileAvatar(
                  selectedImage: getAvatar(),
                  onImagePick: (data) {
                    // Prevents resetting the selected image back to null if the user cancels the action.
                    if (data != null) {
                      setState(() => _selectedImage = data);
                    }
                  },
                ),
                SizedBox(height: size.height * 0.05),
                Text('Profile Title', style: textStyle),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: AuthTextField(controller: _profileTitle),
                ),
                Text('First Name', style: textStyle),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: AuthTextField(controller: _firstNameController),
                ),
                Text('Last Name', style: textStyle),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: AuthTextField(controller: _lastNameController),
                ),
                Text('Job', style: textStyle),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: AuthTextField(controller: _jobController),
                ),
                Text('Company', style: textStyle),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: AuthTextField(controller: _companyController),
                ),
                AuthButton(
                  onTap: () async => saveAll(),
                  text: 'Save',
                  loading: _loading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValid() {
    if (_profileTitle.text.isEmpty) {
      notify(context: context, msg: 'Profile title is a mandatory field.');
      return false;
    }
    if (_firstNameController.text.isEmpty) {
      notify(context: context, msg: 'Your name is empty.');
      return false;
    }
    return true;
  }

  void onFinish() {
    Navigator.pushNamedAndRemoveUntil(context, Routes.home, (_) => false);
  }

  void saveAll() async {
    if (!isValid()) return;
    setState(() {
      _loading = true;
    });
    final FirebaseAuthService auth = context.read<FirebaseAuthService>();
    final String userId = auth.user!.uid;
    await saveUser(userId);
    String? url;
    if (_selectedImage != null) {
      url = await savePhoto(userId, _profileTitle.text);
    }
    await saveProfile(userId, url);
    setState(() {
      _loading = false;
    });
    onFinish();
  }

  Future<void> saveUser(String id) async {
    final UserModel model =
        UserModel(id: id, profiles: 1, defaultProfile: _profileTitle.text);
    final database = context.read<FirestoreDatabaseService>();
    return await database.setUser(user: model);
  }

  Future<void> saveProfile(String userId, String? photoUrl) async {
    final ProfileModel profile = ProfileModel(
      title: _profileTitle.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      jobTitle: _jobController.text,
      company: _companyController.text,
      color: kRedColor.value,
      photoUrl: photoUrl,
    );
    final database = context.read<FirestoreDatabaseService>();
    return await database.setDefaultUserProfile(
      userId: userId,
      profile: profile,
    );
  }

  Future<String?> savePhoto(String userId, String profileTitle) async {
    final storage = context.read<FirebaseStorageService>();
    String? url;
    await storage.uploadProfilePhoto(
      userId: userId,
      profileTitle: profileTitle,
      photo: _selectedImage!,
      onSuccess: (_url) => url = _url,
      onFail: (msg) => notify(context: context, msg: msg),
    );
    return url;
  }

  ImageProvider<Object> getAvatar() {
    if (_selectedImage == null) {
      return const AssetImage('assets/icons/default_avatar.jpg');
    } else {
      return MemoryImage(_selectedImage!);
    }
  }
}
