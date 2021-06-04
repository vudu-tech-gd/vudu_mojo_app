import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/helpers/mojoResult.dart';
import 'package:vudu_mojo_app/models/mojoUser.dart';

abstract class MojoInterface {
  Future<int> logError(Map<String, String> body);
  Future<MojoResult> completeRegistration(Map<String, dynamic> body);
  void apiWarmUp();

  Future<void> createAccountSubmit(BuildContext context, MojoUser user);

  ThemeData lightTheme();
  Color lightSecondaryBackgroundColor();

  ThemeData darkTheme();
  Color darkSecondaryBackgroundColor();

  String loadingImage();

  List<dynamic> newsfeed();
  String logoImage();

  String getUserId();

  String appTitle();

  String nameChangeNotice();
}
