import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/sharedWidgets/validators.dart';

class PasswordFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String?)? onSaved;
  final TextEditingController controller;
  final Color? iconColor;
  final Function? onFieldSubmitted;

  PasswordFormField({
    this.focusNode,
    required this.onSaved,
    required this.controller,
    this.iconColor,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofillHints: [AutofillHints.password],
        textInputAction: TextInputAction.go,
        focusNode: focusNode,
        onFieldSubmitted: (_) {
          onFieldSubmitted!();
        },
        decoration: InputDecoration(
            hintText: 'PASSWORD',
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).hintColor,
                fontSize: 14,
                height: 1.5),
            prefixIcon: Icon(Icons.lock,
                color: iconColor ?? Theme.of(context).accentColor)),
        obscureText: true,
        controller: controller,
        validator: Validators.compose([
          Validators.required('Please enter a password'),
          Validators.minLength(6, 'Password cannot be less than 6 characters')
        ]),
        onSaved: onSaved);
  }
}
