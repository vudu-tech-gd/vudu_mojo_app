import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/bindings/bindingTransition.dart';
import 'package:vudu_mojo_app/helpers/dialogHelper.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/pages/forgottenPassword/forgottenPasswordBindingModel.dart';
import 'package:vudu_mojo_app/services/authService.dart';

class ForgottenPasswordBindingTransition extends BindingTransition {
  final AuthService _authService = locator<AuthService>();
  final _mojo = locator<MojoInterface>();
  final ForgottenPasswordBindingModel _model =
      locator<ForgottenPasswordBindingModel>();

  bool validateForm(GlobalKey<FormState> formKey) {
    if (!formKey.currentState!.validate()) {
      // Invalid!
      return false;
    }
    formKey.currentState!.save();

    return true;
  }

  Future<void> passwordResetRequest(BuildContext context) async {
    await okTransition(
        context: context,
        title: 'Password Reset',
        subTitle: 'Thanks!',
        message:
            'You will shortly receive an email, please follow the instructions to reset your password.',
        loadingImage: 'assets/' + _mojo.loadingImage(),
        loadingText: 'SENDING REQUEST...',
        loadingTask: () async =>
            await _authService.passwordResetRequestAsync(_model.emailAddress),
        onSuccess: () {
          pop(context);
        },
        onFail: ({error, required result, message}) async {
          await DialogHelper.showFailure(context: context, result: result);
        });
  }
}
