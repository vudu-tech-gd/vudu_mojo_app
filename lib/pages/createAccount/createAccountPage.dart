import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/pages/createAccount/createAccountForm.dart';
import 'package:vudu_mojo_app/sharedWidgets/textButton.dart';
import 'package:vudu_mojo_app/pages/page.dart' as Mojo;

class CreateAccountPage extends StatelessWidget {
  static const routeName = '/createAccount';
  final _mojo = locator<MojoInterface>();

  final String? logoImage;
  final String? footerImage;
  final Color? cancelTextColor;

  CreateAccountPage({
    this.logoImage,
    this.footerImage,
    this.cancelTextColor,
  });

  void _cancel(context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Mojo.Page(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          footerImage != null
              ? Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Image(
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                    image: AssetImage(footerImage!),
                  ),
                )
              : Container(),
          Positioned(
              bottom: 10,
              child: MojoTextButton(
                text: 'CANCEL',
                textColor: cancelTextColor ?? Theme.of(context).primaryColor,
                onPressed: _cancel,
              )),
          Container(
              child: CreateAccountForm(
                  logoImage: logoImage ?? 'assets/' + _mojo.logoImage())),
        ],
      ),
    );
  }
}
