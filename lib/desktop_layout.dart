import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DesktopLayout extends StatelessWidget {

  const DesktopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This is Desktop'),
      )
    );
  }
}
