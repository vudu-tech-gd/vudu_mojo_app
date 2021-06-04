import 'package:vudu_mojo_app/bindings/bindingModel.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/services/settingsService.dart';

class SettingsBindingModel extends BindingModel {
  final SettingsService _settingsService = locator<SettingsService>();

  SettingsBindingModel() {
    subscribe(_settingsService);
  }

  bool get hasLocalAuthAndUserMatch =>
      _settingsService.hasLocalAuth() && _settingsService.userMatch();

  String get localAuthType => _settingsService.getLocalAuthType();

  bool get localLoginEnabled => _settingsService.localLoginEnabled();

  bool get localLoginInitialised => _settingsService.localLoginInitialised();

  String get localAuthDescription =>
      'When enabled, enrollment will be requested the next time you login. \n\nOnce enabled and enrolled, subsequent changes to your email and/or password will require re-enrollement. Simply re-enable the feature above to store the new credentials securely on you next login.';
}
