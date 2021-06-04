import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/sharedWidgets/validators.dart';

class EmailFormField extends StatelessWidget {
  final Function onSaved;
  final Function? onFieldSubmitted;
  final FocusNode? focus;
  final FocusNode? nextNode;
  final TextEditingController controller;
  final Color? iconColor;
  final TextInputAction? inputAction;

  EmailFormField({
    required this.onSaved,
    this.focus,
    this.nextNode,
    this.onFieldSubmitted,
    required this.controller,
    this.iconColor,
    this.inputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: [AutofillHints.email],
      textCapitalization: TextCapitalization.none,
      textInputAction: inputAction ?? TextInputAction.next,
      autocorrect: false,
      focusNode: focus,
      onFieldSubmitted: (_) => onFieldSubmitted!(),
      decoration: InputDecoration(
          hintText: 'EMAIL',
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).hintColor,
              fontSize: 14,
              height: 1.5),
          prefixIcon: Icon(
            Icons.email,
            color: iconColor ?? Theme.of(context).accentColor,
          )),
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      validator: Validators.compose([
        Validators.required('Please enter an email address.'),
        Validators.email('Please enter a valid email address.'),
      ]),
      onSaved: (value) {
        onSaved(value);
      },
    );
  }
}
