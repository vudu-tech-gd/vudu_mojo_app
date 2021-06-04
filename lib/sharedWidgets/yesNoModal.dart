import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/helpers/responseHelper.dart';

import '../screen.dart';

class YesNoModal extends StatelessWidget {
  final Color backgroundColour;
  final String title;
  final String subtitle;
  final String message;
  final String? cancelLabel;
  final String? confirmLabel;
  final IconData? icon;
  final Color? iconColour;

  YesNoModal({
    required this.backgroundColour,
    required this.title,
    required this.subtitle,
    required this.message,
    this.cancelLabel,
    this.confirmLabel,
    this.icon,
    this.iconColour,
  });

  void _confirm(context) {
    Navigator.pop(context, true);
  }

  void _cancel(context) {
    Navigator.pop(context, false);
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon ?? Icons.email,
                  color: iconColour ?? Colors.deepPurple,
                  size: 75,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 25,
                    ),
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
                      left: width * .15,
                      right: width * .15,
                      top: height * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                              ResponseHelper.isTablet(context)
                                  ? Screen.width(context) * 0.15
                                  : Screen.width(context) * 0.3,
                              45),
                          primary: Theme.of(context).accentColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25))),
                        ),
                        onPressed: () {
                          _cancel(context);
                        },
                        child: Text(
                            cancelLabel != null && cancelLabel!.isNotEmpty
                                ? cancelLabel!
                                : 'CANCEL',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                              ResponseHelper.isTablet(context)
                                  ? Screen.width(context) * 0.15
                                  : Screen.width(context) * 0.3,
                              45),
                          primary: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25))),
                        ),
                        onPressed: () {
                          _confirm(context);
                        },
                        child: Text(
                            confirmLabel != null && confirmLabel!.isNotEmpty
                                ? confirmLabel!
                                : 'YES',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    ));
  }
}
