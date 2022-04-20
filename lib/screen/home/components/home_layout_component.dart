import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeLayoutComponent extends StatefulWidget {
  final Widget body;
  final Widget footer;

  const HomeLayoutComponent({
    Key? key,
    required this.body,
    required this.footer,
  }) : super(key: key);

  @override
  State<HomeLayoutComponent> createState() => _HomeLayoutComponentState();
}

class _HomeLayoutComponentState extends State<HomeLayoutComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      bottomNavigationBar: widget.footer,
    );
  }
}
