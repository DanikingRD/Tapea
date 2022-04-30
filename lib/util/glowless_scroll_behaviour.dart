import 'package:flutter/material.dart';

class GlowlessScrollBehaviour extends MaterialScrollBehavior {
  const GlowlessScrollBehaviour();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
