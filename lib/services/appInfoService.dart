import 'package:package_info_plus/package_info_plus.dart';
import 'package:vudu_mojo_app/bindings/bindingModel.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/services/service.dart';

class AppInfoService extends Service {
  PackageInfo? _info;

  Future<void> setPackageInfo() async {
    _info = await PackageInfo.fromPlatform();
  }

  PackageInfo getPackageInfo() {
    return _info!;
  }
}

class AppInfoBindingModel extends BindingModel {
  final AppInfoService _appInfoService = locator<AppInfoService>();

  PackageInfo get appInfo => _appInfoService.getPackageInfo();
}
