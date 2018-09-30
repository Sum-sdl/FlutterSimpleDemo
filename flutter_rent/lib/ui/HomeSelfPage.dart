import 'package:flutter/material.dart';

class SelfView extends StatelessWidget {
  SelfView() {
    print("SelfView new");
  }

  Widget content;

  @override
  Widget build(BuildContext context) {
    print("SelfView build StatelessWidget content=$content");
    if (content == null) {
      content = buildScaffold();
    }
    return content;
  }

  Scaffold buildScaffold() {
    print("SelfView build new Scaffold");
    return Scaffold(
        appBar: new AppBar(
          title: new Text("我的"),
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
