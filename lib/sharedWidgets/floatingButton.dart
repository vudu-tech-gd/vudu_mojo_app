import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final IconData? icon;

  FloatingButton({required this.text, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () {
          onPressed(context);
        },
        backgroundColor: Theme.of(context).primaryColor,
        icon: icon != null
            ? Icon(
                icon,
                color: Colors.white,
              )
            : null,
        label: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)));
  }
}
