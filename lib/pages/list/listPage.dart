import 'package:flutter/material.dart';
import 'package:vudu_mojo_app/bindings/inputBinding.dart';
import 'package:vudu_mojo_app/bindings/listBindingModel.dart';
import 'package:vudu_mojo_app/helpers/responseHelper.dart';
import 'package:vudu_mojo_app/sharedWidgets/header.dart';
import 'package:vudu_mojo_app/pages/page.dart' as Mojo;

typedef Widget ListItemWidget(dynamic);

class ListPage<T extends ListBindingModel> extends StatelessWidget {
  final String title;
  final String placeHolder;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color backgroundColor;
  final ListItemWidget listItemWidget;

  ListPage(
      {required this.title,
      required this.placeHolder,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      required this.backgroundColor,
      required this.listItemWidget});

  @override
  Widget build(BuildContext context) {
    return Mojo.Page(
      backgroundColor: backgroundColor,
      safeArea: true,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      child: Column(
        children: <Widget>[
          Header(title: title),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
                left: ResponseHelper.sizeWidth(0, .15, .2, context),
                right: ResponseHelper.sizeWidth(0, .15, .2, context),
              ),
              child: InputBinding<T>(
                builder: (_, container, __) => container.list!.length > 0
                    ? ListView(
                        padding: const EdgeInsets.only(bottom: 100),
                        children: container.list!
                            .map((item) => listItemWidget(item))
                            .toList(),
                      )
                    : Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(40),
                        child: Text(
                          placeHolder,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
