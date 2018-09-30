import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  HomeView() {
    print("HomeView gz");
  }

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    print("HomeView initState");
  }

  @override
  Widget build(BuildContext context) {
    print("HomeView build");
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Home"),
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

  _HomeViewState() {
    print("HomeView _HomeViewState gz");
  }
}
