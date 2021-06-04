import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/helpers/responseHelper.dart';
import 'package:vudu_mojo_app/screen.dart';

class OkModal extends StatelessWidget {
  final Color backgroundColour;
  final String title;
  final String subtitle;
  final String message;
  final Function? success;
  final Function? fail;
  final IconData? icon;
  final Color? iconColour;

  OkModal({
    required this.backgroundColour,
    required this.title,
    required this.subtitle,
    required this.message,
    this.icon,
    this.iconColour,
    this.success,
    this.fail,
  });

  void _success(context) {
    if (success != null) {
      success!();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: this.backgroundColour),
        child: Column(children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            padding: EdgeInsets.only(top: height * 0.05, bottom: height * 0.02),
            width: width,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 25,
                fontFamily: Theme.of(context).textTheme.headline6!.fontFamily,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).backgroundColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Icon(
            icon ?? Icons.email,
            color: iconColour ?? Colors.deepPurple,
            size: 100,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              message,
              style: TextStyle(fontSize: 15, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: width * .15, right: width * .15, top: height * 0.02),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                    ResponseHelper.isTablet(context)
                        ? Screen.width(context) * 0.15
                        : Screen.width(context) * 0.6,
                    45),
                primary: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
              onPressed: () {
                _success(context);
              },
              child: Text('OK',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ]),
      ),
    ));
  }
}
