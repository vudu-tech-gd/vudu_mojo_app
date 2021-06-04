import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/screen.dart';

class DashboardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPressed;
  final bool disabled;

  const DashboardButton({
    required this.title,
    required this.icon,
    required this.onPressed,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey; // Disabled color
            }
            return Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).primaryColorDark
                : Theme.of(context).backgroundColor;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
        ),
        onPressed: disabled
            ? null
            : () {
                onPressed();
              },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Screen.heightOf(1, context),
                horizontal: Screen.widthOf(2, context),
              ),
              child: Icon(
                icon,
                size: Screen.heightOf(5, context),
                color: Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).textTheme.caption?.color
                    : Theme.of(context).primaryColorDark,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).textTheme.caption?.color
                      : Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
