import 'package:flutter/material.dart';

class StringFormField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  StringFormField({
    required this.onSaved,
    this.icon,
    this.hintText = '',
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).hintColor,
            fontSize: 14,
            height: 1.5),
        prefixIcon: Icon(
          icon,
          color: Theme.of(context).accentColor,
        ),
      ),
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return 'Invalid text!';
            }
            return null;
          },
      onSaved: onSaved,
    );
  }
}
