import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/pages/settings/settingsBindingTransition.dart';

class ExampleSettingsBindingTransition extends SettingsBindingTransition {
  @override
  Future<void> editSettings(BuildContext context, String title, dynamic value,
      IconData icon, Function save, String formType) async {}

  @override
  String? getPrivacyPolicyUrlDev() {
    return 'https://dev.vudu.tech/policies/privacy-policy';
  }

  @override
  String? getPrivacyPolicyUrl() {
    return 'https://vudu.tech/policies/privacy-policy';
  }
}
