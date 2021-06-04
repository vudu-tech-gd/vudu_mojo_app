import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/bindings/inputBinding.dart';
import 'package:vudu_mojo_app/helpers/responseHelper.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/services/appInfoService.dart';

class AppInfoForm extends StatelessWidget {
  final _titleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  final _versionStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  final _buildStyle = TextStyle(color: Colors.grey, fontSize: 12);
  final _mojo = locator<MojoInterface>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: 20.0,
          bottom: 20,
          left: ResponseHelper.sizeWidth(.05, .15, .2, context),
          right: ResponseHelper.sizeWidth(.05, .15, .2, context),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50),
            ),
            Text(_mojo.appTitle(), style: _titleStyle),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle),
              child: InputBinding<AppInfoBindingModel>(builder: (_, model, __) {
                return Text(model.appInfo.version, style: _versionStyle);
              }),
              alignment: Alignment.center,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            InputBinding<AppInfoBindingModel>(builder: (_, model, __) {
              return Text('Build ${model.appInfo.buildNumber}',
                  style: _buildStyle);
            }),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Text('Thank you for using ' + _mojo.appTitle() + '!',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).primaryColor)),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Text(
              _mojo.appTitle() +
                  ' is part of a platform that is actively developed by Vudu Technologies Limited, a software engineering company based in Cardiff, South Wales.',
              textAlign: TextAlign.justify,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Text(
                'Feedback is welcomed and will always be reviewed & considered.  Whilst we\'ll make every effort to respond to feedback, we cannot guarantee that we will be able to respond to all feedback.'),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Text(
                'Please include version & build numbers in any feedback submitted, thank you!'),
          ],
        ));
  }
}
