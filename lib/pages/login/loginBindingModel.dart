import 'package:vudu_mojo_app/bindings/bindingModel.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/services/authService.dart';

class LoginBindingModel extends BindingModel {
  AuthService _authService = locator<AuthService>();
  String? email;
  String? password;

  LoginBindingModel() {
    subscribe(_authService);
  }

  bool get isAuthenticated => _authService.isAuthenticated();

  bool get isLogout => _authService.isLogout();
}
