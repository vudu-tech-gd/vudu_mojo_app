import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/helpers/responseHelper.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/pages/forgottenPassword/forgottenPasswordBindingModel.dart';
import 'package:vudu_mojo_app/pages/forgottenPassword/forgottenPasswordBindingTransition.dart';
import 'package:vudu_mojo_app/screen.dart';
import 'package:vudu_mojo_app/sharedWidgets/button.dart';
import 'package:vudu_mojo_app/sharedWidgets/emailFormField.dart';
import 'package:vudu_mojo_app/sharedWidgets/sizedLogo.dart';

typedef ForgottenPasswordBindingModel ModelCallback();

class ForgottenPasswordForm extends StatefulWidget {
  final String? logoImage;
  final ModelCallback modelCallback;
  final ForgottenPasswordBindingTransition transition;

  ForgottenPasswordForm({
    this.logoImage,
    required this.modelCallback,
    required this.transition,
  });

  @override
  _ForgottenPasswordFormState createState() => _ForgottenPasswordFormState();
}

class _ForgottenPasswordFormState extends State<ForgottenPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _mojo = locator<MojoInterface>();

  @override
  Widget build(BuildContext context) {
    var transition = widget.transition;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: Screen.heightOf(5, context),
          ),
          SizedLogo(
            logoImage: widget.logoImage ?? '/assets/' + _mojo.logoImage(),
            width: Screen.widthOf(60, context),
            height: Screen.heightOf(20, context),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Screen.heightOf(1, context),
            ),
            child: Text(
              'Reset Password',
              style: TextStyle(
                  fontSize: Screen.heightOf(4, context),
                  color: Theme.of(context).primaryColor,
                  fontFamily:
                      Theme.of(context).textTheme.headline6!.fontFamily),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: ResponseHelper.sizeWidth(.15, .25, .35, context),
                  right: ResponseHelper.sizeWidth(.15, .25, .35, context),
                  top: Screen.height(context) * .099),
              child: EmailFormField(
                  controller: _emailController,
                  inputAction: TextInputAction.go,
                  onFieldSubmitted: () {
                    if (transition.validateForm(_formKey)) {
                      transition.passwordResetRequest(context);
                    }
                  },
                  onSaved: (value) {
                    widget.modelCallback().emailAddress = value;
                  })),
          Padding(
            padding: EdgeInsets.only(
                left: ResponseHelper.sizeWidth(.15, .35, .35, context),
                right: ResponseHelper.sizeWidth(.15, .35, .35, context),
                top: Screen.height(context) * 0.051),
            child: Button(
                minWidth: Screen.width(context) * 0.6,
                text: 'SUBMIT',
                onPressed: () {
                  if (transition.validateForm(_formKey)) {
                    transition.passwordResetRequest(context);
                  }
                }),
          )
        ],
      ),
    );
  }
}
