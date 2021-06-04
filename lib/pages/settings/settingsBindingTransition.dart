import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/bindings/bindingTransition.dart';

abstract class SettingsBindingTransition extends BindingTransition {
  Future<void> editSettings(BuildContext context, String title, dynamic value,
      IconData icon, Function save, String formType);
  String? getPrivacyPolicyUrlDev();
  String? getPrivacyPolicyUrl();
}
