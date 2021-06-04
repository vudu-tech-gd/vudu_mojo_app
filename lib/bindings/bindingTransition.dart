import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/helpers/mojoResult.dart';
import 'package:vudu_mojo_app/pages/loading/loadingPage.dart';
import 'package:vudu_mojo_app/sharedWidgets/okModal.dart';
import 'package:vudu_mojo_app/sharedWidgets/yesNoModal.dart';
import 'package:vudu_mojo_app/transitions/fadeRoute.dart';

class BindingTransition {
  void pop(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> transition(BuildContext context, Widget target) async {
    await Navigator.push(
      context,
      FadeRoute(page: target),
    );
  }

  Future<void> loadingTransition(
      {required BuildContext context,
      required Function task,
      String? image,
      String? text,
      Function({required dynamic error, required MojoResult result})? onFail,
      Widget? target,
      bool pop = true}) async {
    await Navigator.push(
      context,
      FadeRoute(
        page: LoadingPage<void>(
          image: image,
          text: text,
          task: () async {
            await task();
          },
          onFail: onFail,
          target: target,
          pop: pop,
        ),
      ),
    );
  }

  Future<Object> yesNoTransition({
    required BuildContext context,
    required String title,
    required String subTitle,
    required String message,
    String? cancelLabel,
    String? confirmLabel,
    IconData? icon,
    Color? iconColor,
  }) async {
    return await Navigator.push(
      context,
      FadeRoute(
        page: YesNoModal(
          backgroundColour: Theme.of(context).backgroundColor,
          title: title,
          subtitle: subTitle,
          message: message,
          icon: icon,
          iconColour: iconColor,
          confirmLabel: confirmLabel,
          cancelLabel: cancelLabel,
        ),
      ),
    );
  }

  Future<void> okTransition({
    required BuildContext context,
    required String title,
    required String subTitle,
    required String message,
    IconData? icon,
    Color? iconColor,
    String? loadingImage,
    String? loadingText,
    Function? loadingTask,
    Function? onSuccess,
    Function({required dynamic error, required MojoResult result})? onFail,
    Widget? target,
  }) async {
    var failed = false;
    if (loadingTask != null) {
      await loadingTransition(
        context: context,
        task: loadingTask,
        image: loadingImage,
        text: loadingText,
        onFail: ({error, required result, message}) {
          failed = true;

          if (onFail != null) {
            onFail(error: error, result: result);
          }
        },
      );
    }

    if (!failed) {
      await Navigator.push(
        context,
        FadeRoute(
          page: OkModal(
            backgroundColour: Theme.of(context).backgroundColor,
            title: title,
            subtitle: subTitle,
            message: message,
            icon: icon,
            iconColour: iconColor,
            success: () {
              Navigator.pop(context);

              if (onSuccess != null) {
                onSuccess();
              }
            },
          ),
        ),
      );
    }
  }
}
