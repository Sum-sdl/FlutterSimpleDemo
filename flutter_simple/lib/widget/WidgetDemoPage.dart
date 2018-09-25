import 'package:flutter/material.dart';

class WidgetDemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _WidgetPage();
}

class _WidgetPage extends State<WidgetDemoPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("组件功能测试"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Text("文本提示"),
          new TextField(
            decoration: new InputDecoration(hintText: "EditText Hint"),
          )
        ],
      ),
    );
  }
}
