import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/helpers/responseHelper.dart';

class TextForm extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;
  final Function saveValue;
  final Widget buttons;
  final double width;
  final double height;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  TextForm({
    required this.title,
    required this.value,
    required this.icon,
    required this.saveValue,
    required this.buttons,
    required this.width,
    required this.height,
    this.validator,
    this.keyboardType,
  });

  @override
  _TextFormState createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  @override
  Widget build(BuildContext context) {
    //final width = widget.width;
    final height = widget.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: height * .15),
          child: Icon(
            widget.icon,
            color: Theme.of(context).accentColor,
            size: 80,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: ResponseHelper.sizeWidth(.1, .25, .3, context),
              right: ResponseHelper.sizeWidth(.1, .25, .3, context),
              top: height * .05),
          child: TextFormField(
            initialValue: widget.value,
            decoration: InputDecoration(
              isDense: true,
              hintText: widget.title.toUpperCase(),
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).hintColor,
                fontSize: 14,
              ),
            ),
            keyboardType: widget.keyboardType ?? TextInputType.text,
            validator: widget.validator ??
                (value) {
                  if (value!.isEmpty) {
                    return 'Invalid!';
                  }
                  return null;
                },
            onSaved: (value) {
              widget.saveValue(value);
            },
          ),
        ),
        widget.buttons
      ],
    );
  }
}
