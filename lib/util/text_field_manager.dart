import 'package:flutter/widgets.dart';

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
