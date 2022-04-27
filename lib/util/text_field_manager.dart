import 'package:flutter/widgets.dart';
import 'package:tapea/model/profile_model.dart';

class ListTileFieldManager {
  final String mainFieldLabel;
  final TextEditingController mainFieldController = TextEditingController();
  final TextEditingController labelController = TextEditingController();
  final ProfileFieldType type;
  TextEditingController? phoneExtController;

  ListTileFieldManager({
    required this.mainFieldLabel,
    required this.type,
  }) {
    init();
  }

  void init() {
    if (type == ProfileFieldType.phoneNumber) {
      phoneExtController = TextEditingController();
      phoneExtController!.text = 'Ext.';
    }
    mainFieldController.text = mainFieldLabel;
    labelController.text = 'Label (optional)';
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
