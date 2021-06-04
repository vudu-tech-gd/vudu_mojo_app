import 'package:vudu_mojo_app/sharedWidgets/notificationContainer.dart';
import 'package:vudu_mojo_app/bindings/bindingTransition.dart';

abstract class NotificationBindingTransition extends BindingTransition
    with NotificationContainer {
  List? get list {
    return null;
  }
}
