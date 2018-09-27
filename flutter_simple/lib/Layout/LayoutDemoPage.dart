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
                height:55.0,
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
          child: new Container(
            constraints: new BoxConstraints.expand(
              height: Theme
                  .of(context)
                  .textTheme
                  .display1
                  .fontSize * 1.1 + 200.0,
            ),
            decoration: new BoxDecoration(
              border: new Border.all(width: 2.0, color: Colors.red),
              color: Colors.indigo,
              borderRadius: new BorderRadius.all(new Radius.circular(45.0)),
              image: new DecorationImage(
                image: new NetworkImage(
                    'http://h.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=0d023672312ac65c67506e77cec29e27/9f2f070828381f30dea167bbad014c086e06f06c.jpg'),
                centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
              ),
            ),
            alignment: Alignment.center,
            child: new Text('Expanded',
                style: Theme
                    .of(context)
                    .textTheme
                    .display2
                    .copyWith(color: Colors.black)),
//            transform: new Matrix4.rotationZ(0.3),
          ),
//          flex: 1,
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
