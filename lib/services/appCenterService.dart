import 'package:app_center_bundle_sdk/app_center_bundle_sdk.dart';
import 'package:vudu_mojo_app/services/service.dart';

class AppCenterService extends Service {
  register({required String androidSecret, required String iosSecret}) async {
    if (!isDev) {
      await AppCenter.startAsync(
        appSecretAndroid: androidSecret,
        appSecretIOS: iosSecret,
        enableAnalytics: true,
        enableCrashes: true,
        enableDistribute: true,
        usePrivateDistributeTrack: false,
        disableAutomaticCheckForUpdate: false,
      );

      print('Registered with AppCenter');
    } else {
      print(
          'Development mode - AppCenter not registered, events will be printed to console.');
    }
  }

  Future<void> logEvent(String eventName,
      [Map<String, String>? properties]) async {
    if (isDev) {
      print('Development Mode - Event logged: $eventName, $properties');
    } else {
      await AppCenter.trackEventAsync(
          eventName, properties ?? <String, String>{});
    }
  }

  bool get isDev {
    bool isDev = false;
    assert(isDev = true);

    return isDev;
  }
}
