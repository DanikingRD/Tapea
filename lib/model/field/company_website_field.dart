import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/profile_field.dart';

class CompanyWebsiteField extends LinkField {
  CompanyWebsiteField(
      {String title = '', String subtitle = '', String link = ''})
      : super(
          title: title,
          subtitle: subtitle,
          link: link,
        );

  @override
  String get displayName => 'Company Website';

  @override
  IconData get icon => Icons.web;

  @override
  ProfileFieldType get type => ProfileFieldType.companyWebsite;
}
