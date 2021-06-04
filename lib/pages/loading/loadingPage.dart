import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:vudu_mojo_app/helpers/mojoException.dart';
import 'package:vudu_mojo_app/helpers/mojoResult.dart';
import 'package:vudu_mojo_app/helpers/responseHelper.dart';
import 'package:vudu_mojo_app/helpers/resultType.dart';
import 'package:vudu_mojo_app/screen.dart';
import 'package:vudu_mojo_app/sharedWidgets/sizedLogo.dart';
import 'package:vudu_mojo_app/transitions/fadeRoute.dart';
import 'package:vudu_mojo_app/pages/page.dart' as Mojo;

class LoadingPage<T> extends StatefulWidget {
  final String? image;
  final String? text;
  final bool pop;
  final Function task;
  final Function? onSuccess;
  final Function({required dynamic error, required MojoResult result})? onFail;
  final Widget? target;

  LoadingPage({
    required this.task,
    this.onSuccess,
    this.onFail,
    this.image,
    this.text,
    this.pop = true,
    this.target,
  });

  @override
  _LoadingPageState<T> createState() => _LoadingPageState<T>();
}

class _LoadingPageState<T> extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) {
      callTask();
    });
  }

  void callTask() async {
    Future<T>(() => widget.task()).then((result) {
      if (widget.onSuccess != null) {
        widget.onSuccess!(result);
      }

      if (widget.target != null) {
        Navigator.pushReplacement(context, FadeRoute(page: widget.target!));
      } else if (widget.pop) {
        Navigator.pop(context);
      }
    }).catchError((error) {
      var mojoError = error as MojoException;
      widget.onFail!(error: mojoError.error, result: mojoError.result);
    }, test: (e) => e is MojoException).catchError((error) {
      Navigator.pop(context);
      if (widget.onFail != null) {
        widget.onFail!(
            error: error,
            result: MojoResult(resultType: ResultType.BadRequest));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Mojo.Page(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              widget.image != null
                  ? SizedLogo(
                      logoImage: widget.image!,
                      width: ResponseHelper.isTablet(context)
                          ? Screen.widthOf(30, context)
                          : Screen.widthOf(60, context),
                      height: ResponseHelper.isTablet(context)
                          ? Screen.heightOf(20, context)
                          : Screen.heightOf(40, context),
                    )
                  : Container(),
              SizedBox(height: Screen.heightOf(10, context)),
              SizedBox(
                height: ResponseHelper.isTablet(context)
                    ? Screen.widthOf(10, context)
                    : Screen.widthOf(20, context),
                width: ResponseHelper.isTablet(context)
                    ? Screen.widthOf(10, context)
                    : Screen.widthOf(20, context),
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              // widget.text != null
              //     ? Padding(
              //         padding: EdgeInsets.only(
              //             top: Screen.heightOf(10),
              //             left: Screen.widthOf(20),
              //             right: Screen.widthOf(20)),
              //         child: Text(
              //           widget.text,
              //           style: TextStyle(
              //             fontSize: Screen.heightOf(2.5),
              //             fontWeight: FontWeight.bold,
              //             color: Theme.of(context).primaryColor,
              //           ),
              //           textAlign: TextAlign.center,
              //         ),
              //       )
              //     : Container()
            ],
          ),
        ),
      ),
    );
  }
}
