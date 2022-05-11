import 'package:flutter/material.dart';
import 'package:tapea/constants.dart';

class LoadingIndicatorBox extends StatelessWidget {
  const LoadingIndicatorBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: const LoadingIndicator(),
      decoration: BoxDecoration(
        color: kProfileEditorFieldContainer,
        borderRadius: BorderRadius.circular(26),
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  final Color color;
  const LoadingIndicator({
    Key? key,
    this.color = kRedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
