import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tapea/constants.dart';

class HomeLayout extends StatefulWidget {
  final Widget body;
  final Widget footer;

  const HomeLayout({
    Key? key,
    required this.body,
    required this.footer,
  }) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kHomeBgColor,
      body: SafeArea(
        child: widget.body,
      ),
      bottomNavigationBar: widget.footer,
    );
  }
}
