import 'package:flutter/material.dart';

class MsgView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MsgViewState();
}

class _MsgViewState extends State<MsgView> {

  @override
  void initState() {
    super.initState();
    print("MsgView initState");
  }


  @override
  Widget build(BuildContext context) {
    print("MsgView build");
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Msg"),
        ),
        body: new Container(
          color: Colors.blue,
        ));
  }
}
