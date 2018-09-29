import 'package:flutter/material.dart';

class ListDemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ListPage();
}

class _ListPage extends State<ListDemoPage> {
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      widgets.add(getRow(i));
    }
  }

  Widget getRow(int i) {
    //一次性new全部的widget
    print("list init item widget $i");
    return new GestureDetector(
      child: new Padding(
          padding: new EdgeInsets.all(10.0),
          child: new Text("Row $i ,size->$aSize")),
      onTap: () {
        setState(() {
          _changeSize();
          widgets = new List.from(widgets);
          widgets.add(getRow(widgets.length + 1));
          print('add row $i');
        });
      },
    );
  }

  int aSize = 1;

  _changeSize() {
    setState(() {
      aSize += 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("list  build");

    return new Scaffold(
      body: new ListView(
        children: widgets, //创建之后，item的内容不能变更,
      ),
    );
//

//    return buildScaffold();
  }

  ///根据滚动的item来创建项目
  /// 内容的值变了，item会重新走一次创建
  Scaffold buildScaffold() {
    return new Scaffold(
      body: new ListView.builder(
        itemCount: aSize,
        itemBuilder: (c, index) { //一直滚动，创建可见范围内的item项目
          print("list new item widget $index");
          if (index == 100) {
            return null; //结束滚动
          }
          return new FlatButton(
            onPressed: () {
              _changeSize();
            }, child: new Text("index ->$index,$aSize"),);
        },),
    );
  }
}

class GridDemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _GridPage();
}

class _GridPage extends State<GridDemoPage> {

  var _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Scaffold build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldkey,
      appBar: new AppBar(title: new Text("GridView"), elevation: 1.0,),
      body: new Container(
        color: Colors.lightBlue,
        child: GridView.count(
          crossAxisCount: 4, children: List.generate(300, (index) {
//          return new Center(child: _buildGItem(index, _scaffoldkey),);
          return new SizedBox(
            width: 100.0,
            height: 100.0,
            child: _buildGItem(index, _scaffoldkey),);
        }),
        ),
      ),
    );
  }
}

Widget _buildGItem(int index, GlobalKey<ScaffoldState> key) {
  return new Container(
    color: Colors.orange,
    child: new FlatButton(
      onPressed: () {
        var snackBar = SnackBar(content: Text('"index->${index + 1}"'));
        key.currentState.removeCurrentSnackBar();
        key.currentState.showSnackBar(snackBar);
      },
      textColor: Colors.white,
      splashColor: Colors.blue,
      // 波纹颜色
      child: new Text("index->${index + 1}"),),
  );
}
