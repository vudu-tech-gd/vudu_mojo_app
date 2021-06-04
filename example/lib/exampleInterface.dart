import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/helpers/resultType.dart';
import 'package:vudu_mojo_app/models/mojoUser.dart';
import 'package:vudu_mojo_app/helpers/mojoResult.dart';
import 'dart:ui';
import 'package:vudu_mojo_app/mojoInterface.dart';

class ExampleInterface implements MojoInterface {
  final ThemeData _lightTheme = ThemeData(
    backgroundColor: Colors.white,
    fontFamily: 'Quicksand',
    textTheme: TextTheme(
      headline6: TextStyle(
        fontFamily: 'Sunflower',
        color: const Color(0xFFEBEBEB),
      ),
      caption: TextStyle(
        color: const Color(0xFFA0A8A5),
      ),
    ),
    primaryColor: Color(0xFF952e9c),
    primaryColorDark: const Color(0xFF3D4E6D),
    accentColor: Colors.black,
    hintColor: const Color(0xFFC1B9B9),
    errorColor: const Color(0xFF7B3C3C),
  );

  final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    dialogBackgroundColor: const Color(0xFF1C1C1E),
    fontFamily: 'Quicksand',
    textTheme: TextTheme(
      headline6: TextStyle(
        fontFamily: 'Sunflower',
        color: Colors.grey,
      ),
      caption: TextStyle(
        color: Colors.white,
      ),
    ),
    primaryColor: const Color(0xFF2665B2),
    primaryColorDark: const Color(0xFF1C1C1E),
    accentColor: const Color(0xFF4BCCA7),
    hintColor: const Color(0xFFC1B9B9),
    errorColor: Colors.red,
  );

  @override
  void apiWarmUp() {
    print('api warmup...');
  }

  @override
  String appTitle() {
    return 'Example Mojo App';
  }

  @override
  Future<MojoResult> completeRegistration(Map<String, dynamic> body) async {
    return MojoResult(resultType: ResultType.OK);
  }

  @override
  Future<void> createAccountSubmit(BuildContext context, MojoUser user) async {
    print('create account submit');
  }

  @override
  Color darkSecondaryBackgroundColor() {
    return Colors.black;
  }

  @override
  ThemeData darkTheme() {
    return _darkTheme;
  }

  @override
  String getUserId() {
    return '123';
  }

  @override
  Color lightSecondaryBackgroundColor() {
    return const Color(0xFFe3e9f0);
  }

  @override
  ThemeData lightTheme() {
    return _lightTheme;
  }

  @override
  String loadingImage() {
    return 'vudu-logo.png';
  }

  @override
  Future<int> logError(Map<String, String> body) async {
    return 0;
  }

  @override
  String logoImage() {
    return 'vudu-logo.png';
  }

  @override
  String nameChangeNotice() {
    return 'argh a name change!';
  }

  @override
  List newsfeed() {
    return [];
  }
}
