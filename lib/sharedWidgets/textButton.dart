import 'package:flutter/material.dart';

class MojoTextButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color textColor;
  final EdgeInsets? padding;

  MojoTextButton(
      {required this.text,
      required this.onPressed,
      this.textColor = Colors.white,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: padding),
      child: Text(
        text,
        style: TextStyle(
            color: textColor, fontWeight: FontWeight.bold, fontSize: 15),
      ),
      onPressed: () {
        onPressed(context);
      },
    );
  }
}
