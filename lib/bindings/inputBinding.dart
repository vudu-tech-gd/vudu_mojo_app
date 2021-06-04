import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vudu_mojo_app/bindings/bindingModel.dart';

class InputBinding<T extends BindingModel> extends SingleChildStatelessWidget {
  final bool listen;

  InputBinding({
    Key? key,
    required this.builder,
    this.listen = true,
    Widget? child,
  }) : super(key: key, child: child);

  final Widget Function(BuildContext context, T model, Widget child) builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return builder(
      context,
      Provider.of<T>(context, listen: listen),
      child ?? Container(),
    );
  }
}
