import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/helpers/responseHelper.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/screen.dart';
import 'package:vudu_mojo_app/services/appCenterService.dart';

class UserAvatar extends StatelessWidget {
  final String name;

  final AppCenterService _appCenterService = locator<AppCenterService>();
  final MojoInterface _mojo = locator<MojoInterface>();

  UserAvatar({required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => await _appCenterService
          .logEvent('Avatar Click', {'User': _mojo.getUserId()}),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                    child: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Theme.of(context).primaryColorDark
                              : Theme.of(context).accentColor,
                      child: IconTheme(
                        data: IconThemeData(
                          color: Colors.white,
                          size: Screen.heightOf(3, context),
                        ),
                        child: Icon(Icons.person),
                      ),
                    ),
                    width: ResponseHelper.isTablet(context)
                        ? MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? Screen.widthOf(4, context)
                            : Screen.widthOf(5, context)
                        : Screen.widthOf(8, context),
                    height: Screen.widthOf(8, context),
                    padding: const EdgeInsets.all(2.5),
                    decoration: new BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      shape: BoxShape.circle,
                    )),
                SizedBox(
                  width: Screen.widthOf(3, context),
                ),
                Text(
                  name,
                  style: TextStyle(
                      fontSize: Screen.heightOf(3, context),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).textTheme.caption!.color
                          : Theme.of(context).textTheme.headline6!.color,
                      fontWeight: FontWeight.bold,
                      fontFamily:
                          Theme.of(context).textTheme.headline6!.fontFamily),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
