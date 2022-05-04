import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/profile_field.dart';

class LocationField extends ProfileField {
  LocationField({
    String title = '',
    String subtitle = '',
  }) : super(
          title: title,
          subtitle: subtitle,
          icon: FontAwesomeIcons.locationDot,
          type: ProfileFieldType.location,
        );

  @override
  String get displayName => 'Location';
}
