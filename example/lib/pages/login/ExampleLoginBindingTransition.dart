import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/pages/login/loginBindingTransition.dart';

class ExampleLoginBindingTransition extends LoginBindingTransition {
  Future<void> getDetails(BuildContext context) async {
    print('details retrieved');
  }
}
