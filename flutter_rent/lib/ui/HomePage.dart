import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  HomeView() {
    print("HomeView new");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("首页"),
        ),
        body: new Container(
          color: Colors.black26,
          height: double.infinity,
          alignment: Alignment.bottomCenter,
          child: new Text(
            "Home Bottom",
            style: new TextStyle(fontSize: 20.0, color: Colors.blueAccent),
          ),
        ));
  }
}