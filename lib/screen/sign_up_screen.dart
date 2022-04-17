import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart' as constants;
import 'package:tapea/routes.dart';
import 'package:tapea/service/firebase_auth_service.dart';
import 'package:tapea/util/util.dart';
import 'package:tapea/widget/auth_button.dart';
import 'package:tapea/widget/auth_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _selectedImage;
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signUp() {
    setState(() => _loading = true);
    final FirebaseAuthService service = context.read<FirebaseAuthService>();
    service.signUp(
      email: _emailController.text,
      password: _passwordController.text,
      onFail: notifySignUpError,
      onSuccess: (User? user) async {
        await service.sendEmailVerification();
        notify(
            context: context,
            msg: 'We\'ve sent you an email verification link.',
            onClose: () {
              setState(() => _loading = false);
              Navigator.pushNamed(context, Routes.login);
            });
      },
    );
  }

  void notifySignUpError(String code) {
    // Auth service does not returns an error code for empty fields
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      notify(
        context: context,
        msg: 'The email and password fields are required.',
      );
      return;
    } else {
      notify(
        context: context,
        msg: code,
      );
    }
  }

  void selectImage() async {
    final Uint8List? data = await pickImage();
    // Prevents resetting the selected image back to null if the user cancels the action.
    if (data != null) {
      setState(() => _selectedImage = data);
    }
  }

  ImageProvider<Object> getAvatar() {
    if (_selectedImage == null) {
      return const AssetImage('assets/icons/default_avatar.jpg');
    } else {
      return MemoryImage(_selectedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    const margin = SizedBox(
      height: 24,
    );
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
        centerTitle: true,
      ),
      // appBar: AppBar(
      //   systemOverlayStyle: const SystemUiOverlayStyle(
      //     statusBarIconBrightness: Brightness.dark,
      //   ),
      //   title: const Text(
      //     'Sign Up',
      //   ),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.1),
                // Image.asset(
                //   "assets/images/tapea_logo.png",
                //   height: 64,
                // ),

                // Stack(
                //   children: [
                //     CircleAvatar(
                //       radius: 64,
                //       backgroundImage: getAvatar(),
                //     ),
                //     Positioned(
                //       bottom: -10,
                //       left: 80,
                //       child: IconButton(
                //         onPressed: () async => selectImage(),
                //         icon: const Icon(Icons.add_a_photo),
                //       ),
                //     ),
                //   ],
                // ),
                Text(
                  'Email',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: AuthTextField(
                    controller: _emailController,
                  ),
                ),
                Text(
                  'Password',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: AuthTextField(
                    hiddenText: true,
                    controller: _passwordController,
                  ),
                ),
                margin,
                AuthButton(onTap: () => signUp(), text: 'Sign up'),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Flexible(
                //       child: Container(
                //         height: 1,
                //         color: Colors.black,
                //       ),
                //     ),
                //     const Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 18),
                //       child: Text('OR'),
                //     ),
                //     Flexible(
                //       child: Container(
                //         height: 1,
                //         color: Colors.black,
                //       ),
                //     ),
                //   ],
                // ),
                margin,
                // buildLoginButton(
                //   text: 'Sign up with Google',
                //   img: Image.asset('assets/icons/google.png'),
                //   onTap: () {},
                // ),
                // margin,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Have an account ? '),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, Routes.login),
                      child: Text(
                        'Log in',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildLoginButton({
    required Image img,
    required String text,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: SizedBox(
              width: 35.0,
              height: 35.0,
              child: img,
            ),
          ),
          Text(text)
        ],
      ),
    );
  }
}
