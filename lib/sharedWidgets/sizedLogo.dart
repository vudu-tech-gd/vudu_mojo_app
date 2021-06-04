import 'package:flutter/material.dart';

class SizedLogo extends StatelessWidget {
  final double height;
  final double width;
  final String logoImage;

  SizedLogo(
      {required this.logoImage, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Image(
      height: height,
      width: width,
      image: AssetImage(logoImage),
    );
  }
}
