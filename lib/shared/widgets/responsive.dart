import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    required this.desktop,
    super.key,
    this.tablet,
    this.mobile,
  });
  final Widget desktop;
  final Widget? tablet;
  final Widget? mobile;

  static int desktopBreakpoint = 1024;
  static int mobileBreakpoint = 640;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= desktopBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width < desktopBreakpoint &&
      MediaQuery.sizeOf(context).width >= mobileBreakpoint;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileBreakpoint;

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.sizeOf(context).width;
    if ((maxWidth < mobileBreakpoint) && mobile != null) {
      return mobile!;
    } else if (maxWidth < desktopBreakpoint && tablet != null) {
      return tablet!;
    } else {
      return desktop;
    }
  }
}
