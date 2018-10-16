import 'package:flutter/material.dart';


class SelfView extends StatelessWidget {
  const SelfView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("网页插件"),
        ),
        body: new Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            child: FlatButton(onPressed: () {

            }, child: Text("网页"))));
  }


}

