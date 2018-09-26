import 'package:flutter/material.dart';

class LayoutDemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LayoutState();
}

class _LayoutState extends State<LayoutDemoPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Row+Column+Expanded"),
      ),
      body: buildColumn(),
    );
  }

  /// flex: 1 ->宽度比例
  Column buildColumn() {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(28.0),
                color: Colors.red,
              ),
              flex: 1, //类似宽度比例
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.blue,
              ),
              flex: 2,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(28.0),
                color: Colors.orange,
              ),
              flex: 2,
            ),
          ],
        ),
        Expanded(
          child: Container(
            color: Colors.cyan,
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            color: Colors.amberAccent,
          ),
          flex: 1,
        ),
      ],
    );
  }
}
