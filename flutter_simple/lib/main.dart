import 'package:FlutterSimple/bloc/bloc_test_home.dart';
import 'package:FlutterSimple/eventbus/event_test.dart';
import 'package:FlutterSimple/list/NestedScrollViewDemoPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Constant.dart';
import 'flutter_demo.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Widget Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new StartPage(title: 'Flutter 测试'),
      routes: <String, WidgetBuilder>{
        Page.page_home_1: (BuildContext context) => new StartPage(),
        Page.page_home_listView: (BuildContext context) => new ListDemoPage(),
        Page.page_home_GridView: (BuildContext context) => new GridDemoPage(),
        Page.page_home_widget: (BuildContext context) => new WidgetDemoPage(),
        Page.page_home_widget_bg: (BuildContext context) => new WidgetBgPage(),
        Page.page_home_layout: (BuildContext context) => new LayoutDemoPage(),
        Page.page_layout_table: (BuildContext context) => new TableLayoutPage(),
        Page.page_layout_warp: (BuildContext context) =>
        new FlowWarpLayoutPage(),
        Page.page_thread: (BuildContext context) => new ThreadPage(),
        Page.page_other: (BuildContext context) => new TabbedAppBarSample(),
        Page.page_list_anim: (BuildContext context) => new AnimatedListSample(),
        Page.page_list_nested: (BuildContext context) => new NestedPage(),
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
  int index = 0;

  _addIndex() {
//    setState(() {
//      index++;
//    });
    index++;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Container(
        alignment: Alignment.center,
        color: Colors.cyan,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
          child: new Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              new Container(
                alignment: Alignment.topCenter,
                color: Colors.cyanAccent,
                height: 100.0,
                width: 320.0,
                child: new FlatButton(
                  child: new Text(
                    "帧布局第一层，事件可以透传->${index + 1}",
                    style: new TextStyle(color: Colors.black54, fontSize: 18.0),
                  ),
                  onPressed: () {
                    _addIndex();
                  },
                ),
              ),
//              new IgnorePointer(child: buildColumn(context),),//child 不接受事件，事件传给上一级
//              new AbsorbPointer(child: buildColumn(context),),//child 不接受事件，事件拦截
              new SingleChildScrollView(
                child: buildColumn(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Container 展示区域都拦截了事件
  ///
  //按钮列表
  Widget buildColumn(BuildContext context) {
    return new Container(
      //拦截点击事件
      color: Colors.black26,
      padding: EdgeInsets.only(top: 10.0),
      child: new Flex(
        //Flex 就是LinearLayout
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.max,
        //默认是最大，这里设置最小，类似LinearLayout+warp_content
        //Column内容居中
        children: <Widget>[
          new MaterialButton(
              onPressed: () {
//                Navigator.of(context).push(new CupertinoPageRoute(){});
                Navigator.push(context, CupertinoPageRoute(builder: (c) {
                  return BlocTestPage();
                }));
              },
              child: new Text(
                "BloC业务模式测试", style: TextStyle(color: Colors.yellow),)),
          new MaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                    new CupertinoPageRoute(builder: (c) => EventTest()));
              },
              child: new Text(
                "EventBus测试", style: TextStyle(color: Colors.yellow),)),
          new LongPressDraggable(
              child: new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Page.page_home_widget);
                  },
                  textColor: Colors.white,
                  child: new Text("点击或者长按试试")),
              feedback: new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Page.page_home_widget);
                  },
                  textColor: Colors.white,
                  color: Colors.orange,
                  child: new Text("长按被拖动"))),
          new MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Page.page_home_widget_bg);
              },
              child: new Text("组件背景装饰+文本设置")),
          new FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Page.page_home_layout);
              },
              child: new Text("Row+Column+Expanded")),
          new FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Page.page_list_nested);
              },
              splashColor: Colors.blue,
              child: new Text("NestedPage")),
          new FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Page.page_home_listView);
              },
              splashColor: Colors.blue,
              child: new Text("ListView测试")),
          new FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Page.page_list_anim);
              },
              child: new Text("ListView 动画增删")),
          new FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Page.page_home_GridView);
              },
              child: new Text("GridView")),
          new FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Page.page_layout_table);
              },
              child: new Text("Table")),
          new FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Page.page_layout_warp);
              },
              child: new Text("Warp")),
          new FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Page.page_thread);
              },
              child: new Text("线程功能测试")),
          new FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Page.page_other);
              },
              splashColor: Colors.blueAccent,
              child: new Text("其他功能")),
        ],
      ),
    );
  }
}
