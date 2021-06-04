import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/helpers/responseHelper.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/models/nameDetails.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/sharedWidgets/validators.dart';

class NameForm extends StatefulWidget {
  final NameDetails nameDetails;
  final IconData icon;
  final Function saveValue;
  final Widget buttons;
  final double width;
  final double height;

  NameForm({
    required this.nameDetails,
    required this.icon,
    required this.saveValue,
    required this.buttons,
    required this.width,
    required this.height,
  });

  @override
  _NameFormState createState() => _NameFormState(nameDetails);
}

class _NameFormState extends State<NameForm> {
  NameDetails? _nameDetails;
  FocusNode? _lastNameFocusNode;
  final _mojo = locator<MojoInterface>();

  _NameFormState(nameDetails) {
    _nameDetails = nameDetails;
  }

  _changeFirstname(value) {
    _nameDetails?.firstName = value;
  }

  _changeLastname(value) {
    _nameDetails?.lastName = value;
  }

  _save() {
    widget.saveValue(_nameDetails);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.height;

    final headingStyle = TextStyle(
        fontFamily: 'Sunflower',
        fontSize: 20,
        color: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).textTheme.caption!.backgroundColor
            : Theme.of(context).backgroundColor);
    final textStyle = TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 14,
        color: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).textTheme.caption!.backgroundColor
            : Theme.of(context).backgroundColor);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: height * .05),
          // child: Icon(
          //   widget.icon,
          //   color: Theme.of(context).accentColor,
          //   size: 50,
          // ),
        ),

        Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                width: widget.width * 0.9,
                margin: EdgeInsets.only(top: 25.0),
                decoration: BoxDecoration(
                    //border: Border.all(color: Theme.of(context).primaryColor),
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        offset: Offset(0, 5.0),
                      ),
                    ]),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Text('Want to change your name?',
                          style: headingStyle),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(_mojo.nameChangeNotice(), style: textStyle),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                          'Request your name change using the form below.',
                          style: textStyle),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: (widget.width * 0.9) / 2 - 28,
                child: Stack(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                    ),
                    Icon(Icons.person,
                        color: Theme.of(context).backgroundColor, size: 40),
                  ],
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ),

        ///
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(
                left: ResponseHelper.sizeWidth(.1, .25, .3, context), top: 20),
            child: Text(
              'Requested Firstname',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: ResponseHelper.sizeWidth(.1, .25, .3, context),
            right: ResponseHelper.sizeWidth(.1, .25, .3, context),
          ),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            initialValue: widget.nameDetails.firstName,
            decoration: InputDecoration(
              hintText: 'First name',
              isDense: true,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).hintColor,
                  fontSize: 14,
                  height: 1.5),
            ),
            validator: Validators.compose([
              Validators.required('Please a first name'),
            ]),
            onChanged: (value) {
              _changeFirstname(value);
            },
            onFieldSubmitted: (_) {
              _lastNameFocusNode!.requestFocus();
            },
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(
                left: ResponseHelper.sizeWidth(.1, .25, .3, context), top: 10),
            child: Text(
              'Requested Last name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: ResponseHelper.sizeWidth(.1, .25, .3, context),
            right: ResponseHelper.sizeWidth(.1, .25, .3, context),
          ),
          child: TextFormField(
            focusNode: _lastNameFocusNode,
            textInputAction: TextInputAction.go,
            textCapitalization: TextCapitalization.words,
            initialValue: widget.nameDetails.lastName,
            decoration: InputDecoration(
              hintText: 'Last name',
              isDense: true,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).hintColor,
                  fontSize: 14,
                  height: 1.5),
            ),
            validator: Validators.compose([
              Validators.required('Please enter a last name'),
            ]),
            onChanged: (value) {
              _changeLastname(value);
            },
            onSaved: _save(),
            onFieldSubmitted: (_) {
              _save();
            },
          ),
        ),
        widget.buttons,
        Container(height: 500),
      ],
    );
  }
}
