import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/bindings/duplexBinding.dart';
import 'package:vudu_mojo_app/pages/forgottenPassword/forgottenPasswordBindingModel.dart';
import 'package:vudu_mojo_app/pages/forgottenPassword/forgottenPasswordBindingTransition.dart';
import 'package:vudu_mojo_app/pages/forgottenPassword/forgottenPasswordForm.dart';
import 'package:vudu_mojo_app/sharedWidgets/textButton.dart';
import 'package:vudu_mojo_app/pages/page.dart' as Mojo;

class ForgottenPasswordPage extends StatelessWidget {
  static const routeName = '/forgottenPassword';

  final String? logoImage;
  final String? footerImage;
  final Color? cancelTextColor;

  ForgottenPasswordPage({
    this.logoImage,
    this.footerImage,
    this.cancelTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return DuplexBinding<ForgottenPasswordBindingModel,
        ForgottenPasswordBindingTransition>(
      listen: false,
      builder: (_, model, transition, __) {
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
                    textColor:
                        cancelTextColor ?? Theme.of(context).primaryColor,
                    onPressed: (context) => transition.pop(context),
                  )),
              ForgottenPasswordForm(
                logoImage: logoImage ?? 'assets/' + model.mojo.logoImage(),
                modelCallback: () => model,
                transition: transition,
              ),
            ],
          ),
        );
      },
    );
  }
}
