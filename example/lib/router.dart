import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/pages/createAccount/createAccountPage.dart';
import 'package:vudu_mojo_app/pages/forgottenPassword/forgottenPasswordPage.dart';
import 'package:vudu_mojo_app/transitions/fadeRoute.dart';

import 'pages/login/ExampleLoginPage.dart';

class ExampleRouter {
  static Route<dynamic> generateRoute(
      RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case ExampleLoginPage.routeName:
        return FadeRoute(page: ExampleLoginPage());
      case ForgottenPasswordPage.routeName:
        return FadeRoute(page: ForgottenPasswordPage());
      case CreateAccountPage.routeName:
        return FadeRoute(page: CreateAccountPage());
      default:
        return FadeRoute(
            page: Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ));
    }
  }
}
