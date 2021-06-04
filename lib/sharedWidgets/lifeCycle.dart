import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/services/appCenterService.dart';
import 'package:vudu_mojo_app/services/authService.dart';

class LifeCycle extends StatefulWidget {
  final Widget? child;

  LifeCycle({this.child});

  @override
  _LifeCycleState createState() => _LifeCycleState();
}

class _LifeCycleState extends State<LifeCycle> with WidgetsBindingObserver {
  final AuthService _authService = locator<AuthService>();
  final AppCenterService _appCenterService = locator<AppCenterService>();
  final MojoInterface _mojo = locator<MojoInterface>();

  DateTime? _pausedTimestamp;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      var now = DateTime.now();
      var fiveMinsAgo = now.subtract(Duration(minutes: 5));

      if (_pausedTimestamp!.isBefore(fiveMinsAgo) ||
          !_authService.isAuthenticated()) {
        await _appCenterService.logEvent(
            'Auto Logout - Lifecycle Resumed', {'User': _mojo.getUserId()});
        await _authService.logoutAsync();
        await Navigator.pushNamedAndRemoveUntil(
            context, '/login', (_) => false);
      }
    } else if (state == AppLifecycleState.paused) {
      _pausedTimestamp = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }
}
