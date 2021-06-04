import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/screen.dart';
import 'package:vudu_mojo_app/sharedWidgets/circle.dart';

class NewsCards extends StatefulWidget {
  @override
  _NewsCardsState createState() => _NewsCardsState();
}

class _NewsCardsState extends State<NewsCards> {
  int _index = 0;
  List<dynamic> _newsfeed = [];
  String? _logo;

  @override
  void initState() {
    super.initState();
    var mojo = locator<MojoInterface>();
    _newsfeed = mojo.newsfeed();
    _newsfeed.removeWhere((element) => element['type'] == 'image');
    _logo = mojo.logoImage();

    if (_logo != null && _logo!.isNotEmpty) {
      _newsfeed.insert(0, {'type': 'image', 'data': _logo});
    }
  }

  Widget _getFeedItem(newsfeedItem) {
    if (newsfeedItem['type'] == 'image') {
      return _getImageItem(newsfeedItem['data']);
    } else if (newsfeedItem['type'] == 'text') {
      return _getTextItem(newsfeedItem['title'], newsfeedItem['data']);
    } else {
      return Text("Error");
    }
  }

  Widget _getImageItem(String image) {
    return SizedBox(
        child: Image.network(
      image,
    ));
  }

  Widget _getTextItem(String title, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                data,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getIndicator() {
    List<Widget> list = [];

    for (int i = 0; i < _newsfeed.length; ++i) {
      var offsetIndex = i.toDouble();
      double offset = offsetIndex + 1 * 10;
      list.add(
        Padding(
          padding: EdgeInsets.only(left: offset, right: offset),
          child: CustomPaint(
            key: UniqueKey(),
            painter: Circle(
                color: _index == i
                    ? Theme.of(context).accentColor
                    : Theme.of(context).backgroundColor,
                strokeWidth: 1,
                paintingStyle: PaintingStyle.fill),
          ),
        ),
      );
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            height: Screen.heightOf(20, context),
            width: Screen.widthOf(90, context),
            child: Card(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColorDark
                  : Theme.of(context).backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 6,
              child: PageView.builder(
                itemCount: _newsfeed.length,
                controller: PageController(viewportFraction: 1),
                onPageChanged: (int index) => setState(() => _index = index),
                itemBuilder: (_, i) {
                  return Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Screen.heightOf(2, context)),
                      child: Container(
                        child: _getFeedItem(_newsfeed[i]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ..._getIndicator(),
            ],
          ),
        ],
      ),
    );
  }
}
