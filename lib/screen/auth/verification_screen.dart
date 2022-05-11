import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/routes.dart';
import 'package:tapea/service/firebase_auth_service.dart';
import 'package:tapea/util/responsive.dart';
import 'package:tapea/util/util.dart';
import 'package:tapea/widget/auth_button.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const SizedBox margin = SizedBox(
      height: 20,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify your email'),
        centerTitle: true,
      ),
      body: Responsive(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Lottie.network(
                'https://assets10.lottiefiles.com/packages/lf20_3rlzwL.json',
                height: MediaQuery.of(context).size.height / 2,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Verify your email address',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const Text(
                'We\'ve sent a verification link to your email',
                style: TextStyle(color: kRedColor, fontWeight: FontWeight.bold),
              ),
              margin,
              AuthButton(
                text: 'Resend',
                onTap: () async => resendVerification(context),
              ),
              margin,
              AuthButton(
                text: 'Continue',
                onTap: () async => onContinue(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resendVerification(BuildContext context) async {
    final FirebaseAuthService service = context.read<FirebaseAuthService>();
    if (!service.isEmailVerified) {
      try {
        await service.sendEmailVerification();
        notify(
          context: context,
          msg: 'The verification link was resent!',
        );
      } on FirebaseAuthException catch (exception) {
        notify(context: context, msg: exception.message!);
      }
    }
  }

  void onContinue(BuildContext context) async {
    final FirebaseAuthService service = context.read<FirebaseAuthService>();
    try {
      await service.reloadUser();
    } on FirebaseAuthException catch (exception) {
      notify(msg: exception.message!, context: context);
      return null;
    }
    if (service.isEmailVerified) {
      notify(
        context: context,
        msg: 'Your email has been successfully verified!',
        onClose: () => Navigator.pushReplacementNamed(
          context,
          Routes.profileSetup,
        ),
        content: const Icon(
          Icons.done,
          color: Colors.green,
          size: 40,
        ),
      );
    } else {
      notify(
          context: context,
          msg:
              'We noticed your email address has not been verified. To start using your Tapea account, you need to confirm your email address.');
    }
  }
}
