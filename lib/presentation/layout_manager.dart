import 'package:flutter/material.dart';

class FormFactor {
  static double tablet = 600;
  static double handset = 300;
}

enum ScreenType {tablet, handset}

ScreenType getFormFactor(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > FormFactor.tablet) return ScreenType.tablet;
  return ScreenType.handset;
}

class LayoutManager {
  static Size size(BuildContext context) {
    return MediaQuery.sizeOf(context);
  }

  static bool isPortrait(BuildContext context) {
    final screenSize = size(context);
    return screenSize.width < screenSize.height;
  }

  static bool isLandscape(BuildContext context) {
    final screenSize = size(context);
    return screenSize.width > screenSize.height;
  }

  static ScreenType getFormFactor(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.shortestSide;
    if (deviceWidth > FormFactor.tablet) return ScreenType.tablet;
    return ScreenType.handset;
  }

  static bool isTablet(BuildContext context) {
    return getFormFactor(context) == ScreenType.tablet;
  }
}