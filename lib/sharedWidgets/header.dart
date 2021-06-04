import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Header extends StatelessWidget {
  final String title;

  Header({required this.title});

  void _back(context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      margin: EdgeInsets.only(bottom: height * 0.01),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Container(
            width: width,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily:
                      Theme.of(context).textTheme.headline6!.fontFamily),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: () {
              _back(context);
            },
            icon: Icon(
              FontAwesomeIcons.angleLeft,
              color: Colors.white,
            ),
            iconSize: 50,
          ),
        ],
      ),
    );
  }
}
