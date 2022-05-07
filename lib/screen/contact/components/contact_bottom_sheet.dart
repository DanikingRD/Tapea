import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactBottomSheet extends StatelessWidget {
  const ContactBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          getButton(
            onPressed: () {},
            icon: FontAwesomeIcons.share,
            name: 'View contact',
          ),
          getButton(
            onPressed: () {},
            icon: Icons.send,
            name: 'Share profile',
          ),
          getButton(
            onPressed: () {},
            icon: Icons.delete,
            name: 'Delete contact',
          ),
        ],
      ),
    );
  }

  Widget getButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String name,
  }) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.grey[300])),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Icon(
              icon,
              color: Colors.black,
            ),
          ),
          Text(
            name,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
