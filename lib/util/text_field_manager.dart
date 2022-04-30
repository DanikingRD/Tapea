import 'package:flutter/cupertino.dart';
import 'package:tapea/util/field_identifiers.dart';

class FieldManager {
  final String titleLabel;
  final String subtitleLabel;
  final ProfileFieldType type;
  final IconData icon;
  const FieldManager({
    required this.titleLabel,
    this.subtitleLabel = 'Label (optional)',
    required this.type,
    required this.icon,
  });
}

class TextFieldManager {
  final String label;
  final TextEditingController controller = TextEditingController();

  TextFieldManager({
    required this.label,
  });

  String get text => controller.text;

  void update(String text) => controller.text = text;

  void dispose() {
    controller.dispose();
  }
}
