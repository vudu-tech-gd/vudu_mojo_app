import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vudu_mojo_app/bindings/duplexBinding.dart';
import 'package:vudu_mojo_app/helpers/dialogHelper.dart';
import 'package:vudu_mojo_app/helpers/mojoResult.dart';
import 'package:vudu_mojo_app/helpers/resultType.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/pages/login/loginBindingModel.dart';
import 'package:vudu_mojo_app/pages/login/loginBindingTransition.dart';
import 'package:vudu_mojo_app/pages/login/loginForm.dart';
import 'package:vudu_mojo_app/sharedWidgets/textButton.dart';
import 'package:vudu_mojo_app/pages/page.dart' as Mojo;

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  final String logoImage;
  final Function onLoginSuccess;
  final String? footerImage;
  final Color? createAccountTextColor;

  LoginPage({
    required this.logoImage,
    required this.onLoginSuccess,
    this.footerImage,
    this.createAccountTextColor,
  });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<LoginFormStateContainer> _loginFormStateContainer =
      GlobalKey<LoginFormStateContainer>();
  final _mojo = locator<MojoInterface>();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      var loginModel = locator<LoginBindingModel>();
      var loginTransition = locator<LoginBindingTransition>();

      if (!loginModel.isLogout) {
        var localLogin = await loginTransition.localLogin();

        if (localLogin) {
          var storage = new FlutterSecureStorage();
          loginModel.email = await storage.read(key: 'localLoginEmail');
          loginModel.password = await storage.read(key: 'localLoginPassword');
          await loginTransition.login(
            context: context,
            image: 'assets/' + _mojo.loadingImage(),
            text: 'LOADING DETAILS...',
            onSuccess: widget.onLoginSuccess,
            onFail: ({error, required result}) async {
              loginTransition.disableLocalLogin();
              await DialogHelper.showFailure(
                  context: context,
                  result: MojoResult(resultType: ResultType.LocalLoginFailed));
            },
          );
        }
      }
    });
  }

  Future<void> _onLoginSuccess(context) async {
    var loginTransition = locator<LoginBindingTransition>();
    await loginTransition.enrollLocalLogin(context);

    var loginModel = locator<LoginBindingModel>();
    loginModel.email = '';
    loginModel.password = '';
    await widget.onLoginSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return Mojo.Page(
      child: DuplexBinding<LoginBindingModel, LoginBindingTransition>(
        builder: (context, model, transition, _) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                bottom: 10,
                child: MojoTextButton(
                    text: 'CREATE ACCOUNT',
                    textColor: widget.createAccountTextColor ??
                        Theme.of(context).primaryColor,
                    onPressed: (context) async {
                      _loginFormStateContainer.currentState!.clearForm();
                      await transition.createAccount(context);
                    }),
              ),
              Container(
                  child: LoginForm(
                      key: _loginFormStateContainer,
                      logoImage: widget.logoImage,
                      modelCallback: () => model,
                      transition: transition,
                      onLoginSuccess: _onLoginSuccess)),
            ],
          );
        },
      ),
      footer: widget.footerImage != null
          ? Align(
              alignment: FractionalOffset.bottomCenter,
              child: Image(
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
                image: AssetImage(widget.footerImage!),
              ),
            )
          : Container(),
    );
  }
}
