import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tapea/screen/auth/login/components/recover_account_label.dart';
import 'package:tapea/util/responsive.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/service/firebase_auth_service.dart';
import 'package:tapea/service/firestore_datadase_service.dart';
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
      onSuccess: (User? user) async {
        if (!service.isEmailVerified) {
          Navigator.pushNamed(context, Routes.verification);
        } else {
          await onLoggedIn(user!.uid);
        }
      },
    );
  }

  Future<void> onLoggedIn(String id) async {
    final database = context.read<FirestoreDatabaseService>();
    final bool exists = await database.containsUser(id);
    final String route;
    if (!exists) {
      route = Routes.profileSetup;
    } else {
      route = Routes.home;
    }
    Navigator.pushNamedAndRemoveUntil(context, route, (_) => false);
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
        child: Responsive(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.1),
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
                margin,
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
                Responsive.isDesktopScreen(context)
                    ? const SizedBox(
                        height: 40,
                      )
                    : margin,
                const RecoverAccountLabel(),
                margin,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
