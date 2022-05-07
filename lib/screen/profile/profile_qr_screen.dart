import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileQrScreen extends StatelessWidget {
  const ProfileQrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [Text('SEND QR CODE')],
      ),
    );
  }
}
