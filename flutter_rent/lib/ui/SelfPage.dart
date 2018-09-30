import 'package:flutter/material.dart';

class SelfView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SelfViewState();
}

class _SelfViewState extends State<SelfView> {
  @override
  void initState() {
    super.initState();
    print("SelfView initState");
  }

  @override
  Widget build(BuildContext context) {
    print("SelfView build");
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Self"),
        ),
        body: new Container(
            color: Colors.black26,
            height: double.infinity,
            alignment: Alignment.center,
            child: new ListView.builder(itemBuilder: (c, i) {
              return new Text("index->$i");
            })));
  }
}
