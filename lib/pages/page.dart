import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/screen.dart';

class Page extends StatelessWidget {
  final Widget child;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool safeArea;
  final Color? backgroundColor;
  final Widget? footer;
  final MojoInterface _mojo = locator<MojoInterface>();

  Page(
      {required this.child,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.safeArea = false,
      this.backgroundColor,
      this.footer});

  Widget _content(context) {
    final width = Screen.width(context);
    final height = safeArea
        ? Screen.height(context) -
            Screen.paddingTop(context) -
            Screen.paddingBottom(context)
        : Screen.height(context);

    return Container(
      decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).backgroundColor),
      child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(
            children: <Widget>[
              footer ?? Container(),
              SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Container(width: width, height: height, child: child),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).backgroundColor
          : _mojo.lightSecondaryBackgroundColor(),
      body: safeArea
          ? SafeArea(
              child: _content(context),
            )
          : _content(context),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      resizeToAvoidBottomInset: false,
    );
  }
}
