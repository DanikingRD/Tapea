import 'package:flutter/widgets.dart';
import 'package:tapea/constants.dart';

class Responsive extends StatelessWidget {
  final Widget child;

  const Responsive({
    Key? key,
    required this.child,
  }) : super(key: key);

  static bool isMobileScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < kMobileScreenWidth;
  }

  static bool isTabletScreen(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return size.width < kDesktopScreenWidth && size.width >= kTabletScreenWidth;
  }

  static bool isDesktopScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= kDesktopScreenWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        child: child,
      ),
    );
  }
}
