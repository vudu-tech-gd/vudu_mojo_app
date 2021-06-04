import 'package:vudu_mojo_app/sharedWidgets/listContainer.dart';
import 'package:vudu_mojo_app/bindings/bindingModel.dart';

abstract class ListBindingModel extends BindingModel with ListContainer {
  List? get list {
    return null;
  }
}
