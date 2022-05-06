import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FieldColorPicker extends StatefulWidget {
  const FieldColorPicker({
    Key? key,
  }) : super(key: key);

  @override
  State<FieldColorPicker> createState() => _FieldColorPickerState();
}

class _FieldColorPickerState extends State<FieldColorPicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        itemBuilder: ((context, index) {
          return getSelectableColor();
        }),
      ),
    );
  }

  Widget getSelectableColor() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
