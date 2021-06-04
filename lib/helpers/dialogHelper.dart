import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vudu_mojo_app/helpers/mojoResult.dart';
import 'package:vudu_mojo_app/helpers/resultType.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/screen.dart';
import 'package:vudu_mojo_app/services/appCenterService.dart';
import 'package:vudu_mojo_app/services/authService.dart';
import 'package:vudu_mojo_app/sharedWidgets/button.dart';
import 'package:vudu_mojo_app/sharedWidgets/textButton.dart';

class DialogHelper {
  static Future<void> showFailure(
      {required BuildContext context, required MojoResult? result}) async {
    final AppCenterService _appCenterService = locator<AppCenterService>();
    final MojoInterface _mojo = locator<MojoInterface>();

    var resultToLog = <String, String>{};
    if (result != null) {
      String userId;
      try {
        userId = _mojo.getUserId();
      } catch (e) {
        userId = 'Unable to retrieve User Id';
      }

      resultToLog = {
        'Type': result.resultType.toString(),
        'Message': result.message ?? 'No message',
        'Body': result.body ?? 'No body',
        'User': userId
      };
    }

    await _appCenterService.logEvent('Dialog - Failure', resultToLog);

    String message;
    String dialogTitle = 'Oops!';
    switch (result!.resultType) {
      case ResultType.LoginFailed:
        {
          message =
              'Please check the email address and password you entered and try again.';
          dialogTitle = 'Login Failed';
        }
        break;
      case ResultType.LocalLoginFailed:
        {
          message =
              'Your credentials are out of date, please re-enable biometric login in settings.';
          dialogTitle = 'Login Failed';
        }
        break;
      case ResultType.OutOfSync:
        {
          message =
              'Your session has expired, please log back in and try again';
        }
        break;
      case ResultType.Unauthorized:
        {
          message =
              'Your session has expired, please log back in and try again';
        }
        break;
      default:
        {
          message =
              'There seems to be a problem processing your request, please try again.';
        }
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColorDark
                  : Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          height: Screen.heightOf(55, context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: Screen.heightOf(7, context)),
                child: Icon(
                  FontAwesomeIcons.exclamation,
                  color: Colors.amber,
                  size: 80,
                ),
              ),
              SizedBox(
                height: Screen.heightOf(3, context),
              ),
              Text(
                dialogTitle,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Screen.heightOf(3, context),
                    color: Theme.of(context).primaryColorDark),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Screen.heightOf(3, context),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: Screen.widthOf(5, context),
                    right: Screen.widthOf(5, context)),
                child: Text(
                  message,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.caption?.color),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Screen.heightOf(3, context),
              ),
              Button(
                text: 'OK',
                onPressed: () {
                  Navigator.pop(context);
                },
                minWidth: Screen.widthOf(25, context),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );

    if (result.resultType == ResultType.OutOfSync ||
        result.resultType == ResultType.Unauthorized) {
      var authService = locator<AuthService>();
      await authService.logoutAsync();
      await Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
    }
  }

  static Future<void> showValidationIssue(
      {required BuildContext context}) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColorDark
                  : Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          height: Screen.heightOf(55, context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: Screen.heightOf(7, context)),
                child: Icon(
                  FontAwesomeIcons.fileSignature,
                  color: Colors.amber,
                  size: 80,
                ),
              ),
              SizedBox(
                height: Screen.heightOf(3, context),
              ),
              Text(
                'Oops!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Screen.heightOf(3, context),
                    color: Theme.of(context).primaryColorDark),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Screen.heightOf(3, context),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: Screen.widthOf(5, context),
                    right: Screen.widthOf(5, context)),
                child: Text(
                  'Please review the supplied information in your registration form.',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.caption?.color),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Screen.heightOf(3, context),
              ),
              Button(
                text: 'OK',
                onPressed: () {
                  Navigator.pop(context);
                },
                minWidth: Screen.widthOf(25, context),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> showAccountVerification(
      {required BuildContext context}) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColorDark
                  : Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          height: Screen.heightOf(65, context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: Screen.heightOf(7, context)),
                child: Icon(
                  FontAwesomeIcons.envelopeOpenText,
                  color: Colors.purple,
                  size: 80,
                ),
              ),
              SizedBox(
                height: Screen.heightOf(3, context),
              ),
              Text(
                'Account Verification',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Screen.heightOf(3, context),
                    color: Theme.of(context).primaryColorDark),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Screen.heightOf(3, context),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Please click the verification link in your Welcome email, then press OK to continue',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.caption?.color),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Screen.heightOf(5, context),
              ),
              Button(
                text: 'OK',
                onPressed: () async {
                  var authService = locator<AuthService>();
                  var accountVerified = await authService.isAccountVerified();

                  if (accountVerified) {
                    Navigator.pop(context);
                  }
                },
                minWidth: Screen.widthOf(25, context),
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: Screen.heightOf(3, context),
              ),
              MojoTextButton(
                text: 'RESEND WELCOME EMAIL',
                onPressed: (context) async {
                  var authService = locator<AuthService>();
                  await authService.sendWelcomeEmail();
                },
                textColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
