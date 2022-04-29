import 'package:flutter/widgets.dart';
import 'package:tapea/model/profile_model.dart';

class ListTileFieldManager {
  final String dataLabel;
  final TextEditingController data = TextEditingController();
  final TextEditingController labelController = TextEditingController();
  final ProfileFieldType type;
  TextEditingController? phoneExtController;

  ListTileFieldManager({
    required this.dataLabel,
    required this.type,
  }) {
    init();
  }
  set innerText(String text) => data.text = text;
  set labelText(String text) => labelController.text = text;
  set phoneExtText(String text) {
    if (phoneExtController != null) phoneExtController!.text = text;
  }

  void init() {
    if (type == ProfileFieldType.phoneNumber) {
      phoneExtController = TextEditingController();
      phoneExtController!.text = 'Ext.';
    }
  }
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
