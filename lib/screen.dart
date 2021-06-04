import 'package:flutter/material.dart';

class Screen {
  static double widthOf(double factor, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return factor * (width / 100);
  }

  static double heightOf(double factor, BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return factor * (height / 100);
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double paddingTop(context) {
    return MediaQuery.of(context).padding.top;
  }

  static double paddingBottom(context) {
    return MediaQuery.of(context).padding.bottom;
  }
}
