import 'package:flutter/widgets.dart';
import 'package:tapea/constants.dart';

class ResponsiveLayout extends StatelessWidget {

  final Widget mobileLayout;
  final Widget tabletLayout;
  final Widget desktopLayout;

  const ResponsiveLayout({
    Key? key,
    required this.mobileLayout,
    required this.tabletLayout,
    required this.desktopLayout,
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
    final Size size = MediaQuery.of(context).size;
    // We consider a mobile layout anything between 1 - 600px
    if (size.width <= kMobileScreenWidth) {
      return mobileLayout;
    } else if (size.width >= kMobileScreenWidth && size.width <= kTabletScreenWidth) {
      // Otherwise the width is around tablet and dekstop
      // We consider a tablet layout anything between 601px - 900px
      return tabletLayout;
    } else {
      // Otherwise this is desktop.
      // A desktop layout is anything above 901px.
      return desktopLayout;
    }
  }
}
