import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vudu_mojo_app/bindings/bindingTransition.dart';
import 'package:vudu_mojo_app/helpers/dialogHelper.dart';
import 'package:vudu_mojo_app/helpers/mojoResult.dart';
import 'package:vudu_mojo_app/helpers/responseHelper.dart';
import 'package:vudu_mojo_app/helpers/resultType.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/models/mojoUser.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/pages/settings/settingsBindingTransition.dart';
import 'package:vudu_mojo_app/screen.dart';
import 'package:vudu_mojo_app/sharedWidgets/button.dart';
import 'package:vudu_mojo_app/sharedWidgets/emailFormField.dart';
import 'package:vudu_mojo_app/sharedWidgets/passwordFormField.dart';
import 'package:vudu_mojo_app/sharedWidgets/sizedLogo.dart';

class CreateAccountForm extends StatefulWidget {
  final String logoImage;

  CreateAccountForm({required this.logoImage});

  @override
  _CreateAccountFormState createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _mojo = locator<MojoInterface>();
  final _transition = locator<SettingsBindingTransition>();

  MojoUser _registrationData = MojoUser('', '');

  @override
  void dispose() {
    _passwordFocusNode.dispose();

    super.dispose();
  }

  void openPolicyUrl() async {
    bool isDev = false;
    assert(isDev = true);

    final String url = isDev
        ? _transition.getPrivacyPolicyUrlDev()!
        : _transition.getPrivacyPolicyUrl()!;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      DialogHelper.showFailure(
        context: context,
        result: MojoResult(
            resultType: ResultType.OperationFailed,
            message: 'Failed to load privacy policy',
            body: 'Attempted to load url $url but failed.'),
      );
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState?.save();

    var bindingTransition = BindingTransition();
    await bindingTransition.loadingTransition(
      context: context,
      image: 'assets/' + _mojo.loadingImage(),
      text: 'LOADING REGISTRATION FORM...',
      pop: false,
      task: () async {
        if (!_formKey.currentState!.validate()) {
          return;
        }
        _formKey.currentState?.save();

        _mojo.apiWarmUp();

        _mojo.createAccountSubmit(context, _registrationData);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: Screen.heightOf(5, context),
          ),
          SizedLogo(
            logoImage: widget.logoImage,
            width: Screen.widthOf(60, context),
            height: Screen.heightOf(20, context),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Screen.heightOf(1, context),
            ),
            child: Text(
              'Registration',
              style: TextStyle(
                fontSize: Screen.heightOf(4, context),
                color: Theme.of(context).primaryColor,
                fontFamily: Theme.of(context).textTheme.headline6?.fontFamily,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: ResponseHelper.sizeWidth(.15, .25, .35, context),
              right: ResponseHelper.sizeWidth(.15, .25, .35, context),
              top: Screen.height(context) * .03,
            ),
            child: EmailFormField(
              controller: _emailController,
              onFieldSubmitted: () {
                _passwordFocusNode.requestFocus();
              },
              onSaved: (value) {
                _registrationData.emailAddress = value;
              },
              iconColor: Theme.of(context).accentColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: ResponseHelper.sizeWidth(.15, .25, .35, context),
              right: ResponseHelper.sizeWidth(.15, .25, .35, context),
              top: 15,
            ),
            child: PasswordFormField(
              focusNode: _passwordFocusNode,
              controller: _passwordController,
              onFieldSubmitted: () {
                _submit();
              },
              onSaved: (value) {
                _registrationData.password = value!;
              },
              iconColor: Theme.of(context).accentColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ResponseHelper.sizeWidth(.15, .35, .35, context),
                right: ResponseHelper.sizeWidth(.15, .35, .35, context),
                top: Screen.height(context) * 0.05),
            child: Button(
              minWidth: Screen.width(context) * 0.6,
              text: 'SIGN UP',
              onPressed: _submit,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Screen.width(context) * .15,
              right: Screen.width(context) * .15,
              top: Screen.height(context) * .03,
            ),
            child: GestureDetector(
              onTap: () => openPolicyUrl(),
              child: Text.rich(
                TextSpan(
                  style: TextStyle(fontSize: 10),
                  text:
                      'By clicking SIGN UP you are confirming that you have read and agree with our ',
                  children: [
                    TextSpan(
                      text: 'Policies',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
