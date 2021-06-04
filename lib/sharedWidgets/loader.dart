import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Opacity(
            opacity: 1,
            child: const ModalBarrier(dismissible: false, color: Colors.white),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: new CircularProgressIndicator(
              strokeWidth: 10,
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }
}
