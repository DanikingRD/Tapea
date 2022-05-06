import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/routes.dart';

class LocationField extends ProfileField {
  LocationField({
    String title = '',
    String subtitle = '',
  }) : super(
          title: title,
          subtitle: subtitle,
        );

  @override
  String get displayName => 'Location';
  @override
  IconData get icon => FontAwesomeIcons.locationDot;
  @override
  ProfileFieldType get type => ProfileFieldType.location;

  @override
  String get route => Routes.locationField;
}
