import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String logoImage;

  Logo({required this.logoImage});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(logoImage),
    );
  }
}
