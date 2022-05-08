import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tapea/screen/settings/components/menu_header.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: ListView(
          children: [
            MenuHeader(
              img: Uint8List(0),
              name: 'Luis Daniel',
              email: 'danikingrd@gmail.com',
              onClick: () {},
            ),
            getItem(text: 'Sign Out', icon: Icons.exit_to_app),
          ],
        ),
      ),
    );
  }

  Widget getItem({
    required String text,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
