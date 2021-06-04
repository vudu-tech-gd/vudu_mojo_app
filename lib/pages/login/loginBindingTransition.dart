import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/bindings/bindingTransition.dart';
import 'package:vudu_mojo_app/helpers/mojoResult.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/pages/login/loginBindingModel.dart';
import 'package:vudu_mojo_app/services/appInfoService.dart';
import 'package:vudu_mojo_app/services/authService.dart';
import 'package:vudu_mojo_app/services/settingsService.dart';

class LoginBindingTransition extends BindingTransition {
  AuthService _authService = locator<AuthService>();

  LoginBindingModel _model = locator<LoginBindingModel>();
  final AppInfoService _appInfoService = locator<AppInfoService>();
  SettingsService _settingsService = locator<SettingsService>();

  Future<void> createAccount(BuildContext context) async {
    await Navigator.pushNamed(context, '/createAccount');
  }

  Future<void> forgottenPassword(BuildContext context) async {
    await Navigator.pushNamed(context, '/forgottenPassword');
  }

  Future<bool> localLogin() async {
    return await _settingsService.localLogin();
  }

  Future<void> enrollLocalLogin(BuildContext context) async {
    return await _settingsService.enrollLocalLogin(context);
  }

  Future<void> disableLocalLogin() async {
    await _settingsService.disableLocalLogin();
  }

  Future<void> login({
    required BuildContext context,
    required String image,
    required String text,
    required onSuccess,
    required Function({required dynamic error, required MojoResult result})
        onFail,
  }) async {
    await loadingTransition(
      context: context,
      task: () async {
        await _authService.loginAsync(
            _model.email!, _model.password!, onSuccess);
      },
      image: image,
      text: text,
      onFail: onFail,
    );
  }

  Future<void> dashboard(BuildContext context) async {
    await Navigator.pushNamed(context, '/dashboard');
  }

  Future<void> setPackageInfo() async {
    await _appInfoService.setPackageInfo();
  }
}
