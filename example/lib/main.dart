import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:vudu_mojo_app/bindings/bindingTransition.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/pages/forgottenPassword/forgottenPasswordBindingModel.dart';
import 'package:vudu_mojo_app/pages/forgottenPassword/forgottenPasswordBindingTransition.dart';
import 'package:vudu_mojo_app/pages/login/loginBindingModel.dart';
import 'package:vudu_mojo_app/pages/login/loginBindingTransition.dart';
import 'package:vudu_mojo_app/pages/settings/settingsBindingModel.dart';
import 'package:vudu_mojo_app/pages/settings/settingsBindingTransition.dart';
import 'package:vudu_mojo_app/services/appCenterService.dart';
import 'package:vudu_mojo_app/services/appInfoService.dart';
import 'package:vudu_mojo_app/services/authService.dart';
import 'package:vudu_mojo_app/services/settingsService.dart';
import 'package:vudu_mojo_app/vudu_mojo_app.dart';
import 'package:vudu_mojo_app_example/exampleInterface.dart';
import 'package:vudu_mojo_app_example/pages/login/ExampleLoginBindingTransition.dart';
import 'package:vudu_mojo_app_example/pages/settings/ExampleSettingsBindingTransition.dart';

import 'router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //setupLocator();
  _setupLocatorLocal();
  AppCenterService _appCenterService = locator<AppCenterService>();
  await _appCenterService.register(
      androidSecret: '3d3c33ff-3e25-4c7c-80eb-d5ed50368d64',
      iosSecret: 'ea4ab865-7799-494f-853f-073a67f4711f');

  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Sentry.
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    }
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    if (isInDebugMode) return ErrorWidget(details.exception);
    // In release builds, show a yellow-on-blue message instead:
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'Error!',
          style: TextStyle(color: Colors.yellow),
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  };

  var data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
  var isPhone = data.size.shortestSide < 550;

  if (isPhone) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  await runZonedGuarded<Future<Null>>(() async {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => locator<AuthService>()),
      ChangeNotifierProvider(create: (_) => locator<SettingsService>()),
      ChangeNotifierProvider(create: (_) => locator<AppCenterService>()),
      ChangeNotifierProvider(create: (_) => locator<LoginBindingModel>()),
      ChangeNotifierProvider(create: (_) => locator<AppInfoBindingModel>()),
      ChangeNotifierProvider(create: (_) => locator<SettingsBindingModel>()),
      ChangeNotifierProvider(
          create: (_) => locator<ForgottenPasswordBindingModel>()),
    ], child: MyApp()));
  }, (error, stackTrace) async {
    await _reportError(error, stackTrace);
  });
}

void _setupLocatorLocal() {
  locator.registerLazySingleton<MojoInterface>(() => ExampleInterface());
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<SettingsService>(() => SettingsService());
  locator.registerLazySingleton<AppCenterService>(() => AppCenterService());
  locator.registerLazySingleton<AppInfoService>(() => AppInfoService());
  locator
      .registerLazySingleton<AppInfoBindingModel>(() => AppInfoBindingModel());

  locator.registerLazySingleton<BindingTransition>(() => BindingTransition());
  locator.registerLazySingleton<LoginBindingModel>(() => LoginBindingModel());
  var loginBindingTransition = ExampleLoginBindingTransition();
  locator.registerLazySingleton<LoginBindingTransition>(
      () => loginBindingTransition);
  locator.registerLazySingleton<ExampleLoginBindingTransition>(
      () => loginBindingTransition);
  var settingsBindingModel = SettingsBindingModel();
  locator
      .registerLazySingleton<SettingsBindingModel>(() => settingsBindingModel);
  locator.registerLazySingleton<SettingsBindingTransition>(
      () => ExampleSettingsBindingTransition());
  locator.registerLazySingleton<ForgottenPasswordBindingModel>(
      () => ForgottenPasswordBindingModel());
  locator.registerLazySingleton<ForgottenPasswordBindingTransition>(
      () => ForgottenPasswordBindingTransition());
}

_reportError(error, stackTrace) {
  print(error);
  print(stackTrace);

  Map<String, String> errorLog = {
    'error': error.toString(),
    'stackTrace': stackTrace.toString()
  };

  //logError(errorLog);
}

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _mojo = locator<MojoInterface>();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await VuduMojoApp.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mojo Example App',
      initialRoute: '/login',
      theme: _mojo.lightTheme(),
      darkTheme: _mojo.darkTheme(),
      onGenerateRoute: (settings) {
        return ExampleRouter.generateRoute(settings, context);
      },
    );
  }
}
