import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/bindings/outputBinding.dart';
import 'package:vudu_mojo_app/pages/login/loginPage.dart';
import 'package:vudu_mojo_app_example/pages/login/ExampleLoginBindingTransition.dart';

class ExampleLoginPage extends StatelessWidget {
  static const routeName = LoginPage.routeName;

  @override
  Widget build(BuildContext context) {
    return OutputBinding<ExampleLoginBindingTransition>(
      builder: (context, transition, _) {
        return LoginPage(
          logoImage: 'assets/vudu-logo.png',
          onLoginSuccess: () async {
            await transition.getDetails(context);
            await transition.setPackageInfo();
            await transition.dashboard(context);
          },
        );
      },
    );
  }
}
