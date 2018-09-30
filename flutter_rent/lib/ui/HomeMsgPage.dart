import 'package:flutter/material.dart';

class MsgView extends StatelessWidget {
  MsgView() {
    print("MsgView new");
  }

  @override
  Widget build(BuildContext context) {
    print("MsgView build");
    return Scaffold(
        appBar: new AppBar(
          title: new Text("消息"),
        ),
        body: buildIntrinsicWidth2());
  }

  Widget buildIntrinsicWidth() {
    return new IntrinsicWidth(
      stepHeight: 400.0,
      stepWidth: 400.0,
      child: new Container(
        color: Colors.blue,
        width: 200.0,
        height: 200.0,
      ),);
  }

  Widget buildIntrinsicWidth2() {
    return new IntrinsicHeight(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Container(color: Colors.blue, width: 100.0),
          new Container(color: Colors.red, width: 50.0, height: 50.0,),
          new Container(color: Colors.yellow, width: 150.0),
        ],
      ),
    );
  }
}
