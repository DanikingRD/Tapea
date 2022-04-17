import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart' as constants;
import 'package:tapea/routes.dart';
import 'package:tapea/screen/verification_screen.dart';
import 'package:tapea/service/firebase_auth_service.dart';
import 'package:tapea/util/util.dart';
import 'package:tapea/widget/auth_button.dart';
import 'package:tapea/widget/auth_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void logIn() async {
    if (hasEmptyInputs()) return;
    final FirebaseAuthService service = context.read<FirebaseAuthService>();
    await service.signIn(
      email: _emailController.text,
      password: _passwordController.text,
      onFail: (String msg) => notify(
        context: context,
        msg: msg,
      ),
      onSuccess: (User? user) {
        if (!service.isEmailVerified) {
          Navigator.pushNamed(context, Routes.verification);
        } else {
          notify(
            context: context,
            msg: 'Signed In successfully!',
          );
        }
      },
    );
  }

  bool hasEmptyInputs() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      notify(
        context: context,
        msg: 'The email and password fields are required.',
      );
      return true;
    } else {
      return false;
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
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        title: const Text('Log in'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.1),
              // Flexible(
              //   child: Container(),
              //   flex: 3,
              // ),
              // Image.asset(
              //   "assets/images/tapea_logo.png",
              //   height: 64,
              // ),
              // Flexible(
              //   child: Container(),
              // ),
              const Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: AuthTextField(
                  controller: _emailController,
                ),
              ),
              const Text(
                'Password',
                style: TextStyle(
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
              AuthButton(onTap: () => logIn(), text: 'Log in'),
              // GestureDetector(
              //   onTap: () => logIn(),
              //   child: Container(
              //     child: Text(
              //       'Log in',
              //       style: theme.textTheme.bodyLarge!
              //           .copyWith(color: Colors.white),
              //     ),
              //     width: double.infinity,
              //     alignment: Alignment.center,
              //     padding: const EdgeInsets.symmetric(vertical: 12),
              //     decoration: ShapeDecoration(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       color: constants.kRedColor,
              //     ),
              //   ),
              // ),
              margin,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Forgot your login details? '),
                  Text(
                    'Get help',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              //     margin,
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
              // margin,
              // buildLoginButton(
              //     text: 'Sign in with Google',
              //     img: Image.asset('assets/icons/google.png'),
              //     onTap: () {}),
              // margin,
              // Flexible(child: Container()),
              // Container(
              //   height: 1,
              //   width: double.infinity,
              //   color: Colors.black,
              // ),
              // margin,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not a member yet? '),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, Routes.signUp),
                    child: Text(
                      'Sign up',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              margin,
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildLoginButton(
      {required Image img, required String text, required Function() onTap}) {
    return InkWell(
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
