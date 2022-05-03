import 'package:flutter/material.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/widget/circle_icon.dart';

class FieldGridView extends StatelessWidget {
  final List<IconData> fields;
  final Function(int index) onFieldPressed;
  const FieldGridView({
    Key? key,
    required this.fields,
    required this.onFieldPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: kProfileEditorFieldContainer,
      ),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 50,
        crossAxisCount: 3,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        children: List.generate(3, (index) {
          return CircleIconButton(
            heroTag: Text('btn#$index'),
            onPressed: () => onFieldPressed(index),
            icon: Icon(
              fields[index],
              color: Colors.white,
            ),
          );
        }),
      ),
    );
  }
}
