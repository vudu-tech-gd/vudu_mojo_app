import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vudu_mojo_app/bindings/bindingModel.dart';
import 'package:vudu_mojo_app/bindings/bindingTransition.dart';
import 'package:vudu_mojo_app/locator.dart';

class DuplexBinding<T extends BindingModel, U extends BindingTransition>
    extends SingleChildStatelessWidget {
  final bool listen;

  DuplexBinding({
    Key? key,
    required this.builder,
    this.listen = true,
    Widget? child,
  }) : super(key: key, child: child);

  final Widget Function(
      BuildContext context, T model, U transition, Widget child) builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return builder(
      context,
      Provider.of<T>(context, listen: listen),
      locator<U>(),
      child ?? Container(),
    );
  }
}
