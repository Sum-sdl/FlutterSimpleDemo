import 'package:FlutterSimple/Layout/LayoutDemoPage.dart';
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
        Page.page_home_layout: (BuildContext context) => new LayoutDemoPage(),
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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        //居中
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: new Stack(
            children: <Widget>[
              new Container(
                color: Colors.amberAccent,
                padding: EdgeInsets.all(15.0),
                child: new Text(
                  "Statck 帧布局",
                  style:
                  new TextStyle(color: Colors.red, fontSize: 18.0),
                ),
              ),
              buildColumn(context)
            ],
          ),
        ),
      ),
    );
  }

  //按钮
  Widget buildColumn(BuildContext context) {
    return new Container(
      color: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: new Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.max,
          //默认是最大，这里设置最小，类似LinearLayout+warp_content
          //Column内容居中
          children: <Widget>[

            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Page.page_home_widget);
                },
                child: new Text("按钮组件")),
            new MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Page.page_home_widget_bg);
                },
                child: new Text("组件背景装饰+文本设置")),
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Page.page_home_layout);
                },
                child: new Text("Row+Column+Expanded")), new FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Page.page_home_listView);
                },
                color: Colors.white30,
                splashColor: Colors.blue, // 波纹颜色
                child: new Text("ListView测试")),
          ],
        ),
      ),);
  }
}
