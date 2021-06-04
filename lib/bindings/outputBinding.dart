import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vudu_mojo_app/bindings/bindingTransition.dart';
import 'package:vudu_mojo_app/locator.dart';

class OutputBinding<T extends BindingTransition>
    extends SingleChildStatelessWidget {
  final bool listen;

  OutputBinding({
    Key? key,
    required this.builder,
    this.listen = false,
    Widget? child,
  }) : super(key: key, child: child);

  final Widget Function(BuildContext context, T transition, Widget child)
      builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return builder(
      context,
      locator<T>(),
      child ?? Container(),
    );
  }
}
