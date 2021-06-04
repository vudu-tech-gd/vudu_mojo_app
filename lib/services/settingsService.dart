import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:vudu_mojo_app/bindings/bindingTransition.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/pages/login/loginBindingModel.dart';
import 'package:vudu_mojo_app/services/authService.dart';
import 'package:vudu_mojo_app/services/service.dart';

class SettingsService extends Service {
  LoginBindingModel _loginBindingmodel = locator<LoginBindingModel>();
  AuthService _authService = locator<AuthService>();
  final _mojo = locator<MojoInterface>();
  bool? _hasLocalAuth;
  String? _localAuthType;
  bool _localLoginEnabled = false;
  bool _localLoginInitialised = false;
  String? _localLoginUid;

  bool hasLocalAuth() {
    return _hasLocalAuth!;
  }

  bool userMatch() {
    return (!_localLoginEnabled && _localLoginUid == null) ||
        _authService.user.uid == _localLoginUid;
  }

  String getLocalAuthType() {
    return _localAuthType!;
  }

  bool localLoginEnabled() {
    return _localLoginEnabled;
  }

  bool localLoginInitialised() {
    return _localLoginInitialised;
  }

  Future<void> disableLocalLogin() async {
    await toggleLocalAuth(false);
  }

  Future<void> toggleLocalAuth(bool localAuth) async {
    if (localAuth != _localLoginEnabled) {
      _localLoginEnabled = localAuth;
      var storage = new FlutterSecureStorage();
      if (localAuth) {
        await storage.write(key: 'localLoginEnabled', value: 'true');
      } else {
        await storage.write(key: 'localLoginEnabled', value: 'false');
      }
      await storage.delete(key: 'localLoginEmail');
      await storage.delete(key: 'localLoginPassword');
      await storage.delete(key: 'localLoginInitialised');
      await storage.delete(key: 'localLoginUid');
      _localLoginInitialised = false;
      _localLoginUid = null;
    }
    notifyListeners();
  }

  Future<void> _setLocalAuthType(LocalAuthentication localAuth) async {
    List<BiometricType> availableBiometrics =
        await localAuth.getAvailableBiometrics();

    if (Platform.isIOS) {
      if (availableBiometrics.contains(BiometricType.face)) {
        _localAuthType = 'Face Id';
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        _localAuthType = 'Touch Id';
      }
    } else {
      _localAuthType = 'Fingerprint Login';
    }
  }

  Future<bool> localLogin() async {
    var localAuth = LocalAuthentication();
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    await _setLocalAuthType(localAuth);
    _hasLocalAuth = canCheckBiometrics && _localAuthType != null;

    if (_hasLocalAuth!) {
      var storage = new FlutterSecureStorage();
      var localLoginString = await storage.read(key: 'localLoginEnabled');
      var localLoginInitialisedString =
          await storage.read(key: 'localLoginInitialised');
      _localLoginUid = await storage.read(key: 'localLoginUid');

      _localLoginEnabled =
          localLoginString != null && localLoginString.toLowerCase() == 'true';
      _localLoginInitialised = localLoginInitialisedString != null &&
          localLoginInitialisedString.toLowerCase() == 'true';

      if (_localLoginEnabled && _localLoginInitialised) {
        bool authenticated = await localAuth.authenticate(
            biometricOnly: true,
            localizedReason:
                'Please authenticate to login to ' + _mojo.appTitle());

        if (authenticated) {
          return true;
        } else {
          return false;
        }
      }
    }

    return false;
    //check localLogin, if no or null, process to username/password, if yes, prompt with popup
    //username/password login
    //check localLogin, if null, show dialog would you like to use touch id/fingerprint/faceid
    //if no, set localLogin to 'no' in storage, proceed to dashboard
    //if yes, save localLogin yes, email/pass to storage, attempt app reset
  }

  Future<void> enrollLocalLogin(BuildContext context) async {
    if (_hasLocalAuth!) {
      var storage = new FlutterSecureStorage();
      var localLoginString = await storage.read(key: 'localLoginEnabled');
      var localLoginInitialisedString =
          await storage.read(key: 'localLoginInitialised');

      if (localLoginString == null ||
          (localLoginString.toLowerCase() == 'true' &&
              localLoginInitialisedString == null)) {
        var transition = BindingTransition();
        var enroll = await transition.yesNoTransition(
          context: context,
          title: _localAuthType! + ' Enrollment',
          subTitle: '',
          message: 'Would you like you like to enable ' + _localAuthType! + '?',
          confirmLabel: 'CONFIRM',
          icon: _localAuthType == 'Face Id'
              ? Icons.face_sharp
              : Icons.fingerprint,
          iconColor: Colors.orangeAccent,
        );

        if (enroll.toString().toLowerCase() == 'true') {
          await storage.write(key: 'localLoginEnabled', value: 'true');
          await storage.write(key: 'localLoginInitialised', value: 'true');
          await storage.write(
              key: 'localLoginUid', value: _authService.user.uid);

          _localLoginEnabled = true;
          _localLoginInitialised = true;
          _localLoginUid = _authService.user.uid;

          await storage.write(
              key: 'localLoginEmail', value: _loginBindingmodel.email);
          await storage.write(
              key: 'localLoginPassword', value: _loginBindingmodel.password);
        } else {
          await storage.write(key: 'localLoginEnabled', value: 'false');
          _localLoginEnabled = false;
          _localLoginInitialised = false;
          _localLoginUid = null;
        }
      }
    }
  }
}
