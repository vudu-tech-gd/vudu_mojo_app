import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/services/service.dart';

class BindingModel extends ChangeNotifier {
  List<Service> _services = [];
  final _mojo = locator<MojoInterface>();

  @protected
  void subscribe(Service service) {
    service.addListener(update);
    _services.add(service);
  }

  void update() {
    notifyListeners();
  }

  MojoInterface get mojo => _mojo;

  @override
  void dispose() {
    _services.forEach((s) => s.removeListener(update));
    super.dispose();
  }
}
