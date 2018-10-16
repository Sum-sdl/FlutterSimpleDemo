import 'package:flutter/material.dart';

class HouseListView extends StatefulWidget {

  const HouseListView();

  @override
  State<StatefulWidget> createState() {
    return new _HouseListViewState();
  }
}

class _HouseListViewState extends State<HouseListView> {

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }

  Scaffold buildScaffold() {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("房源列表"),
        ),
        body: new Container(
            color: Colors.black26,
            alignment: Alignment.center,
            child: new ListView.builder(itemBuilder: (c, i) {
              return new Text("index house ->$i");
            })));
  }
}
