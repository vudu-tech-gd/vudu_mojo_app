import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:vudu_mojo_app/helpers/responseHelper.dart';
import 'package:vudu_mojo_app/sharedWidgets/validators.dart';

class DateForm extends StatefulWidget {
  final String title;
  final DateTime? value;
  final IconData icon;
  final Function saveValue;
  final Widget buttons;
  final double width;
  final double height;

  DateForm({
    required this.title,
    required this.value,
    required this.icon,
    required this.saveValue,
    required this.buttons,
    required this.width,
    required this.height,
  });

  @override
  _DateFormState createState() => _DateFormState();
}

class _DateFormState extends State<DateForm> {
  TextEditingController _date = new TextEditingController();
  DateTime? _selectedValue;
  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
    _date.value =
        TextEditingValue(text: DateFormat('dd/MM/yyyy').format(widget.value!));
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await DatePicker.showDatePicker(
      context,
      minTime: DateTime(1900),
      maxTime: DateTime(2100),
      currentTime: widget.value ?? DateTime.parse('1990-01-01'),
      locale: LocaleType.en,
    );

    if (picked != null && picked != widget.value)
      setState(() {
        _selectedValue = picked;
        _date.value =
            TextEditingValue(text: new DateFormat('dd/MM/yyyy').format(picked));
      });
  }

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
          child: InkWell(
            onTap: () {
              _selectDate(context); // Call Function that has showDatePicker()
            },
            child: IgnorePointer(
              child: new TextFormField(
                controller: _date,
                decoration: new InputDecoration(
                  hintText: 'DOB',
                  isDense: true,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).hintColor,
                      fontSize: 14,
                      height: 1.5),
                ),
                validator: Validators.required('Please select a date'),
                onSaved: (value) {
                  widget.saveValue(
                      DateFormat('yyyy-MM-dd').format(_selectedValue!));
                },
              ),
            ),
          ),
        ),
        widget.buttons
      ],
    );
  }
}
