import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vudu_mojo_app/vudu_mojo_app.dart';

void main() {
  const MethodChannel channel = MethodChannel('vudu_mojo_app');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await VuduMojoApp.platformVersion, '42');
  });
}
