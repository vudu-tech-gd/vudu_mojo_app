import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

class ResponseHelper {
  static bool isTablet(BuildContext context) {
    var breakpoint = Breakpoint.fromMediaQuery(context);
    if (breakpoint.device == LayoutClass.largeTablet ||
        breakpoint.device == LayoutClass.smallTablet ||
        breakpoint.device == LayoutClass.desktop) {
      return true;
    }

    return false;
  }

  static double sizeWidth(double mobileSize, double tabletSize,
      double tabletLandscapeSize, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return tabletLandscapeSize * width;
    }
    if (isTablet(context)) {
      return tabletSize * width;
    }

    return mobileSize * width;
  }
}
