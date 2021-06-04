import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/helpers/responseHelper.dart';

class ToggleForm extends StatefulWidget {
  final String title;
  final bool value;
  final IconData icon;
  final Function saveValue;
  final Widget buttons;
  final double width;
  final double height;
  final String description;

  ToggleForm({
    required this.title,
    required this.value,
    required this.icon,
    required this.saveValue,
    required this.buttons,
    required this.width,
    required this.height,
    required this.description,
  });

  @override
  _ToggleFormState createState() => _ToggleFormState(value);
}

class _ToggleFormState extends State<ToggleForm> {
  bool value;

  _ToggleFormState(this.value);

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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title),
                  Switch(
                    value: value,
                    onChanged: (val) {
                      setState(() {
                        value = val;
                        widget.saveValue(val);
                      });
                    },
                  ),
                ],
              ),
              Text(
                widget.description,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        widget.buttons
      ],
    );
  }
}
