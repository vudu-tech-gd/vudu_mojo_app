import 'package:get_it/get_it.dart';
import 'package:vudu_mojo_app/bindings/bindingTransition.dart';
import 'package:vudu_mojo_app/pages/forgottenPassword/forgottenPasswordBindingModel.dart';
import 'package:vudu_mojo_app/pages/forgottenPassword/forgottenPasswordBindingTransition.dart';
import 'package:vudu_mojo_app/pages/login/loginBindingModel.dart';
import 'package:vudu_mojo_app/services/appCenterService.dart';
import 'package:vudu_mojo_app/services/appInfoService.dart';
import 'package:vudu_mojo_app/services/authService.dart';
import 'package:vudu_mojo_app/services/settingsService.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<SettingsService>(() => SettingsService());
  locator.registerLazySingleton<AppCenterService>(() => AppCenterService());
  locator.registerLazySingleton<AppInfoService>(() => AppInfoService());
  locator
      .registerLazySingleton<AppInfoBindingModel>(() => AppInfoBindingModel());

  locator.registerLazySingleton<BindingTransition>(() => BindingTransition());
  locator.registerLazySingleton<LoginBindingModel>(() => LoginBindingModel());
  locator.registerLazySingleton<ForgottenPasswordBindingModel>(
      () => ForgottenPasswordBindingModel());
  locator.registerLazySingleton<ForgottenPasswordBindingTransition>(
      () => ForgottenPasswordBindingTransition());
}
