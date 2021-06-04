import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vudu_mojo_app/bindings/inputBinding.dart';
import 'package:vudu_mojo_app/helpers/dialogHelper.dart';
import 'package:vudu_mojo_app/helpers/mojoResult.dart';
import 'package:vudu_mojo_app/helpers/responseHelper.dart';
import 'package:vudu_mojo_app/helpers/resultType.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/pages/login/loginBindingModel.dart';
import 'package:vudu_mojo_app/pages/login/loginBindingTransition.dart';
import 'package:vudu_mojo_app/pages/settings/settingsBindingModel.dart';
import 'package:vudu_mojo_app/screen.dart';
import 'package:vudu_mojo_app/sharedWidgets/button.dart';
import 'package:vudu_mojo_app/sharedWidgets/emailFormField.dart';
import 'package:vudu_mojo_app/sharedWidgets/passwordFormField.dart';
import 'package:vudu_mojo_app/sharedWidgets/sizedLogo.dart';
import 'package:vudu_mojo_app/sharedWidgets/textButton.dart';

typedef LoginBindingModel ModelCallback();

class LoginForm extends StatefulWidget {
  final String logoImage;
  final Function onLoginSuccess;
  final ModelCallback modelCallback;
  final LoginBindingTransition transition;

  LoginForm({
    required Key key,
    required this.logoImage,
    required this.modelCallback,
    required this.transition,
    required this.onLoginSuccess,
  }) : super(key: key);

  @override
  LoginFormStateContainer createState() => LoginFormStateContainer();
}

class LoginFormStateContainer extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _mojo = locator<MojoInterface>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordNode = FocusNode();

  void _forgottenPassword(context) {
    clearForm();
    widget.transition.forgottenPassword(context);
  }

  Future<void> _onLoginSuccess() async {
    clearFormForLogin();
    await widget.onLoginSuccess(context);
  }

  Future<void> _submit(ctx) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    await widget.transition.login(
      context: ctx,
      image: 'assets/' + _mojo.loadingImage(),
      text: 'LOADING DETAILS...',
      onSuccess: _onLoginSuccess,
      onFail: ({error, required result}) async {
        _passwordController.clear();
        await DialogHelper.showFailure(
            context: context,
            result: MojoResult(resultType: ResultType.LoginFailed));
        _passwordNode.requestFocus();
      },
    );
  }

  Future<void> localLogin() async {
    var localLogin = await widget.transition.localLogin();

    if (localLogin) {
      var storage = new FlutterSecureStorage();
      widget.modelCallback().email = await storage.read(key: 'localLoginEmail');
      widget.modelCallback().password =
          await storage.read(key: 'localLoginPassword');
      await widget.transition.login(
        context: context,
        image: 'assets/' + _mojo.loadingImage(),
        text: 'LOADING DETAILS...',
        onSuccess: () async {
          await widget.onLoginSuccess(context);
        },
        onFail: ({error, required result}) async {
          widget.transition.disableLocalLogin();
          await DialogHelper.showFailure(
              context: context,
              result: MojoResult(resultType: ResultType.LocalLoginFailed));
        },
      );
    }
  }

  void clearFormForLogin() {
    _emailController.clear();
    _passwordController.clear();
  }

  void clearForm() {
    _emailController.clear();
    _passwordController.clear();
    widget.modelCallback().email = '';
    widget.modelCallback().password = '';
  }

  @override
  void dispose() {
    _passwordNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: Screen.heightOf(5, context),
          ),
          Center(
              child: SizedLogo(
            logoImage: widget.logoImage,
            width: Screen.widthOf(60, context),
            height: Screen.heightOf(20, context),
          )),
          Padding(
            padding: EdgeInsets.only(
              top: Screen.heightOf(1, context),
            ),
            child: Text(
              'Login',
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
              ),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: height * .03),
                      child: EmailFormField(
                        onSaved: (value) {
                          widget.modelCallback().email = value;
                        },
                        focus: _emailFocus,
                        onFieldSubmitted: () {
                          _emailFocus.unfocus();
                          FocusScope.of(context).requestFocus(_passwordNode);
                        },
                        controller: _emailController,
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                    ),
                    child: PasswordFormField(
                      onSaved: (value) {
                        widget.modelCallback().password = value;
                      },
                      onFieldSubmitted: () {
                        _submit(context);
                      },
                      controller: _passwordController,
                      focusNode: _passwordNode,
                    ),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(
                left: ResponseHelper.sizeWidth(.15, .35, .35, context),
                right: ResponseHelper.sizeWidth(.15, .35, .35, context),
                top: height * 0.05,
              ),
              child: Button(
                text: 'LETS GO!',
                onPressed: () {
                  _submit(context);
                },
                minWidth: width * 0.6,
              )),
          MojoTextButton(
            padding: EdgeInsets.only(top: height * .05),
            text: 'FORGOTTEN PASSWORD?',
            textColor: Theme.of(context).primaryColor,
            onPressed: _forgottenPassword,
          ),
          SizedBox(
            height: Screen.height(context) * .03,
          ),
          InputBinding<SettingsBindingModel>(builder: (_, model, __) {
            return model.localLoginEnabled && model.localLoginInitialised
                ? FloatingActionButton(
                    onPressed: localLogin,
                    child: Icon(
                      model.localAuthType == 'Face Id'
                          ? Icons.face_sharp
                          : Icons.fingerprint,
                      color: Colors.white,
                      size: ResponseHelper.isTablet(context)
                          ? MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? Screen.widthOf(4, context)
                              : Screen.widthOf(5, context)
                          : Screen.widthOf(8, context),
                    ),
                  )
                : Container();
          })
        ],
      ),
    );
  }
}
