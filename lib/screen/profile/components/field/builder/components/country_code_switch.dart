import 'package:flutter/material.dart';
import 'package:tapea/constants.dart';

class CountryCodeSwitch extends StatelessWidget {
  final bool useCountryCode;
  final Function(bool value) onSwitch;

  const CountryCodeSwitch({
    Key? key,
    required this.useCountryCode,
    required this.onSwitch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: getSwitch(),
        ),
        Text(
          'Use international number',
          style: TextStyle(color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget getSwitch() {
    return Switch.adaptive(
      value: useCountryCode,
      activeColor: kSelectedPageColor,
      onChanged: (value) => onSwitch(value),
    );
  }
}
