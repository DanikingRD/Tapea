import 'package:flutter/widgets.dart';
import 'package:tapea/model/field/company_website_field.dart';
import 'package:tapea/screen/profile/field/builder/profile_field_builder.dart';

class CompanyWebsiteFieldScreen extends StatelessWidget {
  final VoidCallback onSaved;
  const CompanyWebsiteFieldScreen({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileFieldScreenBuilder(
      textFieldLabel: 'Company Website',
      field: CompanyWebsiteField(),
      onSaved: onSaved,
      suggestions: const [
        'Website',
        'Visit our website',
      ],
    );
  }
}
