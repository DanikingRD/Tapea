import 'package:flutter/widgets.dart';
import 'package:tapea/model/field/location_field.dart';
import 'package:tapea/screen/profile/components/field/builder/profile_field_builder.dart';

class LocationFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;
  const LocationFieldScreen({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
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
