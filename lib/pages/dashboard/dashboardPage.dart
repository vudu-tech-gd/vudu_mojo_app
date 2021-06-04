import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/bindings/notificationBindingTransition.dart';
import 'package:vudu_mojo_app/bindings/outputBinding.dart';
import 'package:vudu_mojo_app/helpers/responseHelper.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/models/dashboardButtonData.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/pages/dashboard/dashboardButton.dart';
import 'package:vudu_mojo_app/pages/dashboard/newsCards.dart';
import 'package:vudu_mojo_app/pages/dashboard/settingsButton.dart';
import 'package:vudu_mojo_app/screen.dart';
import 'package:vudu_mojo_app/services/appCenterService.dart';
import 'package:vudu_mojo_app/sharedWidgets/logo.dart';
import 'package:vudu_mojo_app/sharedWidgets/userAvatar.dart';
import 'package:vudu_mojo_app/pages/page.dart' as Mojo;

class DashboardPage<T extends NotificationBindingTransition>
    extends StatelessWidget {
  static const routeName = '/dashboard';

  final String logoImage;
  final List<DashboardButtonData> dashboardButtons;
  final Widget? header;
  final Color backgroundColor;
  final String avatarName;
  final _mojo = locator<MojoInterface>();

  final AppCenterService _appCenterService = locator<AppCenterService>();

  DashboardPage({
    required this.logoImage,
    required this.dashboardButtons,
    this.header,
    required this.backgroundColor,
    required this.avatarName,
  });

  @override
  Widget build(BuildContext context) {
    return Mojo.Page(
      backgroundColor: backgroundColor,
      safeArea: true,
      child: Container(
        color: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).backgroundColor
            : _mojo.lightSecondaryBackgroundColor(),
        child: Stack(
          children: <Widget>[
            Container(
                height: Screen.heightOf(38, context),
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                width: Screen.width(context),
                child: header != null ? header : Container()),
            Column(
              children: <Widget>[
                //////////////////////////////////////////// to go in header
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Screen.widthOf(6, context),
                      vertical: Screen.heightOf(1, context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      UserAvatar(name: avatarName),
                      SettingsButton(),
                    ],
                  ),
                ),
                //SizedBox(height: 20,),
                NewsCards(),
                //////////////////////////////////////////// to go in header
                Container(
                  width: Screen.width(context),
                  height: Screen.heightOf(55, context),
                  child: OutputBinding<T>(
                    builder: (context, item, _) => GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(
                        left: Screen.widthOf(6, context),
                        right: Screen.widthOf(6, context),
                        top: ResponseHelper.isTablet(context)
                            ? Screen.heightOf(14, context)
                            : Screen.heightOf(2, context),
                      ),
                      crossAxisCount: ResponseHelper.isTablet(context) ? 4 : 2,
                      crossAxisSpacing: Screen.widthOf(3, context),
                      mainAxisSpacing: Screen.heightOf(3, context),
                      children: dashboardButtons
                          .map(
                            (db) => Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                DashboardButton(
                                  title: db.title,
                                  icon: db.icon,
                                  onPressed: db.onPressed,
                                  disabled: db.disabled,
                                ),
                                db.hasNotification && item.hasNotification()
                                    ? Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Icon(
                                          db.notificationIcon,
                                          color: db.notificationIconColor,
                                          size: ResponseHelper.isTablet(context)
                                              ? Screen.widthOf(3, context)
                                              : Screen.widthOf(7, context),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Screen.heightOf(2, context),
                        bottom: Screen.heightOf(2, context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.start, //top
                      children: <Widget>[
                        GestureDetector(
                          child: Logo(logoImage: logoImage),
                          onTap: () async => {
                            await _appCenterService.logEvent(
                              'Dashboard Logo Click',
                              {'User': _mojo.getUserId()},
                            ),
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
