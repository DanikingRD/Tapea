import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/location_field.dart';
import 'package:tapea/screen/profile/field/profile_field_builder.dart';

class LocationFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;
  const LocationFieldScreen({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      title: 'Add Address',
      fieldIcon: FontAwesomeIcons.locationDot,
      textFieldLabel: 'Address',
      suggestions: const [
        'Work',
        'Office',
        'Mailing Address',
      ],
      field: LocationField(),
      onSaved: onSaved,
    );
  }
}
