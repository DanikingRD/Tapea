import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:tapea/provider/profile_notifier.dart';

class FieldColorPicker extends StatelessWidget {
  final void Function(Color color) onChanged;
  const FieldColorPicker({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getPicker(context);
  }

  Widget getPicker(BuildContext context) {
    final notifier = context.watch<ProfileNotifier>();
    return BlockPicker(
      pickerColor: notifier.color,
      layoutBuilder: _layoutBuilder,
      itemBuilder: _itemBuilder,
      onColorChanged: (color) => onChanged(color),
    );
  }

  Widget _itemBuilder(
      Color color, bool isCurrentColor, void Function() changeColor) {
    return Container(
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.8),
              offset: const Offset(1, 2),
              blurRadius: 5)
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeColor,
          borderRadius: BorderRadius.circular(50),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 210),
            opacity: isCurrentColor ? 1 : 0,
            child: Icon(Icons.done,
                color: useWhiteForeground(color) ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _layoutBuilder(BuildContext _, List<Color> colors, PickerItem child) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (BuildContext context, int index) {
          return child(colors[index]);
        },
      ),
    );
  }
}
