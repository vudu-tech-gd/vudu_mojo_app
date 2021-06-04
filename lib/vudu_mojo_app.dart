
import 'dart:async';

import 'package:flutter/services.dart';

class VuduMojoApp {
  static const MethodChannel _channel =
      const MethodChannel('vudu_mojo_app');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
