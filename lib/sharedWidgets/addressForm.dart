import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/helpers/responseHelper.dart';
import 'package:vudu_mojo_app/models/addressDetails.dart';
import 'package:vudu_mojo_app/sharedWidgets/validators.dart';

class AddressForm extends StatefulWidget {
  final AddressDetails value;
  final IconData? icon;
  final Function saveValue;
  final Widget buttons;
  final double width;
  final double height;
  final bool header;
  final FocusNode? focus;
  final FocusNode? nextFocusNode;
  final bool responseOverride;

  AddressForm({
    required this.value,
    required this.icon,
    required this.saveValue,
    required this.buttons,
    required this.width,
    required this.height,
    this.header = true,
    this.focus,
    this.nextFocusNode,
    this.responseOverride = false,
  });

  @override
  _AddressFormState createState() => _AddressFormState(value);
}

class _AddressFormState extends State<AddressForm> {
  AddressDetails? _address;

  _AddressFormState(value) {
    _address = value;
  }

  _changeAddress(value) {
    _address!.address = value;
  }

  _changePostcode(value) {
    _address!.postcode = value.toString().toUpperCase();
  }

  _save() {
    widget.saveValue(_address);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final width = widget.width;
    final height = widget.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        widget.header
            ? Padding(
                padding: EdgeInsets.only(top: height * .05),
                child: Icon(
                  widget.icon,
                  color: Theme.of(context).accentColor,
                  size: 50,
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
          child: TextFormField(
            autofillHints: [AutofillHints.streetAddressLine1],
            initialValue: widget.value.address,
            focusNode: widget.focus,
            textInputAction: TextInputAction.newline,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              border: new OutlineInputBorder(borderRadius: BorderRadius.zero),
              hintText: 'Address',
              isDense: true,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).hintColor,
                  fontSize: 14,
                  height: 1.5),
            ),
            validator: Validators.required('Please enter an address'),
            onSaved: (value) {
              _save();
            },
            onChanged: (value) {
              _changeAddress(value);
            },
            maxLines: 5,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(
                left: widget.responseOverride
                    ? 20
                    : ResponseHelper.sizeWidth(.1, .25, .3, context),
                top: 10),
            child: Text(
              'POSTCODE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: widget.responseOverride
                ? 20
                : ResponseHelper.sizeWidth(.1, .25, .3, context),
            right: widget.responseOverride
                ? 20
                : ResponseHelper.sizeWidth(.1, .25, .3, context),
          ),
          child: TextFormField(
              autofillHints: [AutofillHints.postalCode],
              textInputAction: Platform.isAndroid
                  ? TextInputAction.none
                  : widget.nextFocusNode != null
                      ? TextInputAction.next
                      : TextInputAction.unspecified,
              textCapitalization: TextCapitalization.characters,
              initialValue: widget.value.postcode,
              decoration: InputDecoration(
                hintText: 'Post code',
                isDense: true,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).hintColor,
                    fontSize: 14,
                    height: 1.5),
              ),
              validator: Validators.compose([
                Validators.required('Please enter a post code'),
                Validators.patternString(
                    r'([Gg][Ii][Rr] 0[Aa]{2})|((([A-Za-z][0-9]{1,2})|(([A-Za-z][A-Ha-hJ-Yj-y][0-9]{1,2})|(([A-Za-z][0-9][A-Za-z])|([A-Za-z][A-Ha-hJ-Yj-y][0-9][A-Za-z]?))))\s?[0-9][A-Za-z]{2})',
                    'Please enter a valid post code')
              ]),
              onChanged: (value) {
                _changePostcode(value);
              },
              onFieldSubmitted: (_) {
                if (widget.focus != null && widget.nextFocusNode != null) {
                  widget.focus?.unfocus();
                  FocusScope.of(context).requestFocus(widget.nextFocusNode);
                }
              }),
        ),
        widget.buttons,
      ],
    );
  }
}
