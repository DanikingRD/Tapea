import 'package:flutter/cupertino.dart';
import 'package:tapea/model/field/paypal_field.dart';
import 'package:tapea/screen/profile/components/field/builder/profile_field_builder.dart';

class PaypalFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;
  const PaypalFieldScreen({Key? key, required this.onSaved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      textFieldLabel: 'Profile',
      suggestions: const ['Paypal'],
      field: PaypalField(),
      onSaved: onSaved,
    );
  }
}
