import 'package:flutter/material.dart';

class SelfView extends StatelessWidget {

  const SelfView();

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }

  Scaffold buildScaffold() {
    print("SelfView build");
    return Scaffold(
        appBar: new AppBar(
          title: new Text("我的"),
          toolbarOpacity: 0.4,
          bottom: PreferredSize(child: Text("Hello"), preferredSize: Size(100.0, 50.0)),
        ),
        body: new Container(
            color: Colors.black26,
            alignment: Alignment.center,
            child: new ListView.builder(
                itemCount: 20,
                itemBuilder: (c, i) {
//                  print("ListView item new $i");
                  return SizedBox(
                    height: 50.0,
                    child: new Text("my index->$i"),
                  );
                })));
  }
}
