import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/screen/settings/components/account_option.dart';
import 'package:tapea/screen/settings/components/option_header.dart';

class SettingsView extends StatelessWidget {
  static const List<Widget> _options = [
    AccountOption(title: 'FREE'),
    AccountOption(title: 'Default Card'),
  ];
  static const List<Widget> _headers = [
    OptionHeader(
      title: 'PLAN',
    ),
    AccountOption(title: 'Default Card'),
  ];
  const SettingsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kHomeBgColor,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      backgroundColor: kHomeBgColor,
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return ListView(
            shrinkWrap: true,
            children: List<Widget>.generate(_options.length, (index) {
              final Widget header = _headers[index];
              return Column(
                children: [],
              );
            }),
          );
        },
      ),
    );
  }

  Widget getItem({
    required String text,
    required IconData icon,
  }) {
    return TextButton(
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}
