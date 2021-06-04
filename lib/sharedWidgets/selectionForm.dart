import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/helpers/responseHelper.dart';

class SelectionForm extends StatefulWidget {
  final String? value;
  final IconData? icon;
  final Function saveValue;
  final Widget buttons;
  final double width;
  final double height;
  final bool header;
  final List<DropdownMenuItem<String>> selection;
  final String? validationError;
  final String hintText;
  final GlobalKey<FormFieldState>? selectionKey;
  final bool disabled;
  final bool responseOverride;
  final FocusNode? selectFocus;
  final FocusNode? nextFocus;

  SelectionForm({
    required this.value,
    required this.icon,
    required this.saveValue,
    required this.buttons,
    required this.width,
    required this.height,
    this.header = true,
    required this.selection,
    this.validationError,
    required this.hintText,
    this.selectionKey,
    this.disabled = false,
    this.responseOverride = false,
    this.selectFocus,
    this.nextFocus,
  });

  @override
  _SelectionFormState createState() =>
      _SelectionFormState(this.value, this.selection);
}

class _SelectionFormState extends State<SelectionForm> {
  String _selection = '';
  final key = GlobalKey<FormFieldState>();

  _SelectionFormState(value, List<DropdownMenuItem<String>> selection) {
    var noMatch = selection.where((element) => element.value == value).isEmpty;

    if (noMatch) {
      _selection = '';
    } else {
      _selection = value;
    }
  }

  _fieldFocusChange(
      BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
    if (currentFocus != null) {
      currentFocus.unfocus();
    }
    if (nextFocus != null) {
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        widget.header
            ? Padding(
                padding: EdgeInsets.only(top: height * .1),
                child: Icon(
                  widget.icon,
                  color: Theme.of(context).accentColor,
                  size: 80,
                ),
              )
            : Container(),
        Padding(
          padding: EdgeInsets.only(
              left: widget.responseOverride
                  ? 20
                  : ResponseHelper.sizeWidth(.1, .25, .3, context),
              right: widget.responseOverride
                  ? 20
                  : ResponseHelper.sizeWidth(.1, .25, .3, context),
              top: widget.header ? height * .05 : height * 0.01),
          child: DropdownButtonFormField<String>(
            key: widget.selectionKey ?? key,
            focusNode: widget.selectFocus,
            decoration: InputDecoration(
                isDense: true, contentPadding: EdgeInsets.all(0)),
            hint: Text(widget.hintText),
            items: widget.selection,
            value: _selection,
            validator: (value) {
              if (value == null || value == '') {
                return widget.validationError ?? 'Invalid!';
              }
              return null;
            },
            onChanged: widget.disabled
                ? null
                : (value) {
                    setState(() {
                      _selection = value!;
                    });

                    widget.saveValue(_selection);

                    _fieldFocusChange(
                        context, widget.selectFocus, widget.nextFocus);
                  },
            isExpanded: true,
          ),
        ),
        widget.buttons
      ],
    );
  }
}
