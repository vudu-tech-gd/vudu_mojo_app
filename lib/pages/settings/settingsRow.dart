import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vudu_mojo_app/helpers/dialogHelper.dart';
import 'package:vudu_mojo_app/helpers/mojoResult.dart';
import 'package:vudu_mojo_app/helpers/resultType.dart';
import 'package:vudu_mojo_app/pages/settings/settingsBindingTransition.dart';

class SettingsRow extends StatelessWidget {
  final String title;
  final dynamic value;
  final IconData icon;
  final Function? save;
  final String formType;
  final String? textValue;
  final SettingsBindingTransition transition;

  SettingsRow({
    required this.title,
    required this.value,
    required this.icon,
    required this.save,
    required this.formType,
    required this.transition,
    this.textValue,
  });

  String get env {
    bool isDev = false;
    assert(isDev = true);

    return isDev ? 'dev' : 'live';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        onTap: () async {
          if (title == 'Privacy Policy') {
            final String url = env == 'dev'
                ? transition.getPrivacyPolicyUrlDev()!
                : transition.getPrivacyPolicyUrl()!;

            if (await canLaunch(url)) {
              await launch(url);
            } else {
              DialogHelper.showFailure(
                  context: context,
                  result: MojoResult(
                      resultType: ResultType.OperationFailed,
                      message: 'Failed to load privacy policy',
                      body: 'Attempted to load url $url but failed.'));
            }
          } else {
            if (save != null) {
              await transition.editSettings(
                  context, title, value, icon, save!, formType);
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColorDark
                  : Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          padding: EdgeInsets.only(left: 10, right: 20),
          height: 70,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 40,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).accentColor
                    : Theme.of(context).primaryColorDark,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .caption!
                                .backgroundColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        textValue ?? value.toString(),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
              save != null
                  ? Icon(
                      Icons.arrow_forward_ios,
                      size: 30,
                      color: Colors.grey,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
