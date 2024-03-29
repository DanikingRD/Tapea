import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/widget/circle_icon.dart';

class FieldGridView extends StatelessWidget {
  final List<ProfileField> fields;
  final Function(ProfileField field) onFieldPressed;
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: kProfileEditorFieldContainer,
      ),
      child: GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        padding: const EdgeInsets.only(top: 16.0),
        children: List.generate(fields.length, (index) {
          final field = fields[index];
          return Column(
            children: [
              CircleIconButton(
                circleColor: context.watch<ProfileNotifier>().color,
                heroTag: Text('btn#$index'),
                onPressed: () => onFieldPressed(field),
                icon: Icon(
                  field.icon,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(field.displayName),
              )
            ],
          );
        }),
      ),
    );
  }
}
