import 'package:FlutterSimple/list/ListDemoPage.dart';
import 'package:FlutterSimple/widget/WidgetDemoPage.dart';
import 'package:flutter/material.dart';

import 'Constant.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Simple',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new StartPage(title: 'Flutter Simple Start'),
      routes: <String, WidgetBuilder>{
        Page.page_home_1: (BuildContext context) => new StartPage(),
        Page.page_home_listView: (BuildContext context) => new ListDemoPage(),
        Page.page_home_widget: (BuildContext context) => new WidgetDemoPage(),
        Page.page_home_widget_bg: (BuildContext context) => new WidgetBgPage(),
      },
    );
  }
}

class StartPage extends StatefulWidget {
  StartPage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  State<StatefulWidget> createState() => new _HomePageList();
}

//_HomePageList 能够获取到StartPage里面的参数title
class _HomePageList extends State<StartPage> {

  String text = "static title";
  int index = 0;

  _textClick() {
    setState(() {
      text = "${index++}";
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center( //居中
        child: new Column( //Column内容居中
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new GestureDetector(child: new Text(
              '文本点击:' + text,
              style: new TextStyle(color: Colors.red, fontSize: 18.0),
            ), onTap: () {
              _textClick();
            }),
            new MaterialButton(onPressed: () {
              Navigator.of(context).pushNamed(Page.page_home_listView);
            }, child: new Text("ListView测试")),
            new MaterialButton(onPressed: () {
              Navigator.of(context).pushNamed(Page.page_home_widget);
            }, child: new Text("按钮组件")),
            new MaterialButton(onPressed: () {
              Navigator.of(context).pushNamed(Page.page_home_widget_bg);
            }, child: new Text("组件背景装饰+文本设置")),
          ],
        ),
      )
      ,
    );
  }
}
