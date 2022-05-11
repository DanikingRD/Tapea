import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapea/screen/auth/sign_up/components/sign_up_label.dart';
import 'package:tapea/util/responsive.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/service/firebase_auth_service.dart';
import 'package:tapea/util/util.dart';
import 'package:tapea/widget/auth_button.dart';
import 'package:tapea/widget/auth_text_field.dart';
import 'package:tapea/widget/loading_indicator.dart';

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
      onFail: (msg) => notifySignUpError(
        code: msg,
        onClose: () => setState(() => _loading = false),
      ),
      onSuccess: (User? user) async {
        await service.sendEmailVerification();
        notify(
          context: context,
          msg: 'We\'ve sent you an email verification link.',
          onClose: () {
            setState(() => _loading = false);
            Navigator.pushNamed(context, Routes.login);
          },
        );
      },
    );
  }

  void notifySignUpError({
    Function()? onClose,
    required String code,
  }) {
    // Auth service does not returns an error code for empty fields
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      notify(
        context: context,
        msg: 'The email and password fields are required.',
        onClose: onClose,
      );
      return;
    } else {
      notify(context: context, msg: code, onClose: onClose);
    }
  }

  AppBar getAppBar() {
    const text = Text('Sign up');
    if (Responsive.isMobileScreen(context)) {
      return AppBar(
        title: text,
        centerTitle: true,
      );
    } else {
      return AppBar(
        title: text,
        centerTitle: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    const margin = SizedBox(
      height: 24,
    );
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: getAppBar(),
      body: _loading
          ? const LoadingIndicator()
          : Responsive(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.1),
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
                    margin,
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
                    Responsive.isDesktopScreen(context)
                        ? const SizedBox(
                            height: 40,
                          )
                        : margin,
                    const SignUpLabel(),
                  ],
                ),
              ),
            ),
    );
  }
}
