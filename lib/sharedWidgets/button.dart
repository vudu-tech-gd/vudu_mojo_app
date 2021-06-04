import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final double minWidth;
  final Color? color;

  Button({
    required this.text,
    required this.onPressed,
    this.minWidth = 0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(minWidth, 45),
        primary: color ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      onPressed: onPressed,
      child: Text(text,
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}
