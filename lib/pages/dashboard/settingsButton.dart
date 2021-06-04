import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/helpers/responseHelper.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/screen.dart';
import 'package:vudu_mojo_app/services/appCenterService.dart';

class SettingsButton extends StatelessWidget {
  final AppCenterService _appCenterService = locator<AppCenterService>();
  final _mojo = locator<MojoInterface>();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.settings,
        color: Colors.white,
        size: ResponseHelper.isTablet(context)
            ? MediaQuery.of(context).orientation == Orientation.landscape
                ? Screen.widthOf(4, context)
                : Screen.widthOf(5, context)
            : Screen.widthOf(8, context),
      ),
      onPressed: () async {
        await _appCenterService
            .logEvent('Settings Click', {'User': _mojo.getUserId()});

        await Navigator.pushNamed(context, '/settings');
      },
    );
  }
}
