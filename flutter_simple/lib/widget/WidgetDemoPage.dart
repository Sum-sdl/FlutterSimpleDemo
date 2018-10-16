import 'package:FlutterSimple/Constant.dart';
import 'package:flutter/material.dart';

class WidgetDemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _WidgetButton();
}

//按钮界面
class _WidgetButton extends State<WidgetDemoPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: false,
        title: new Text("常用按钮"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new FlatButton(
                // 扁平化按钮
                onPressed: () {
                  print('Click FlatButton');
                },
                color: Colors.orange,
                child: new Text('FlatButton'),
                splashColor: Colors.blue, // 波纹颜色
              ),
              new RaisedButton(
                // 具有阴影效果的按钮
                onPressed: () {
                  print('Click RaisedButton');
                },
                color: Color(0xffff639b),
                splashColor: Colors.blue, // 波纹颜色
                child: new Text('RaisedButton'),
              ),
              new FloatingActionButton(
                // 悬浮按钮
                onPressed: () {
                  print('FloatingActionButton');
                  /// 首页main启动的界面可以启动
                  /// 第二个界面TabbedAppBarSample启动，无法启动对应界面
                  Navigator.of(context).pushNamed(Page.page_home_widget_bg);
                },
                child: Icon(Icons.directions_car)
              ),
              new IconButton(
                // 图片按钮
                  icon: Icon(Icons.ac_unit),
                  onPressed: () {
                    print('IconButton');
                  }),
              new RawMaterialButton(
                //原声是按钮
                onPressed: () {
                  print('RawMaterialButton');
                },
                padding: EdgeInsets.all(7.0),
                child: new Text('RawMaterialButton'),
              ),
              new CloseButton(), // 关闭按钮
              new BackButton(), // 返回按钮
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetBgPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _WidgetBg();
}

//背景色+文本样式
class _WidgetBg extends State<WidgetBgPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(

        title: new Text("文本样式+Container装饰"),
        centerTitle: true,
      ),
      body: content(),
    );
  }

  Container content() {
    return new Container(
//        height: 300.0,
      decoration: new BoxDecoration(
//          shape: BoxShape.circle,
        gradient: new LinearGradient(colors: <Color>[
          Colors.deepOrange,
          Colors.orange,
        ]),
//          color: Color(0xffff639b),
        // borderRadius: new BorderRadius.circular(8.0),
//          boxShadow: <BoxShadow>[
//            new BoxShadow(
//              color: const Color(0xffff639b),
//              blurRadius: 1.0,
//              spreadRadius: 1.0,
//              offset: Offset(-1.0, 1.0),
//            ),
//          ],
      ),
      child: new Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, right: 9.0),
          child: Column(//Column不能超出内容
            children: <Widget>[
              new Text(
                'Custom Button',
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  inherit: false, //设置false时,关闭继承的属性
                ),
              ),
              new Text(
                'fontWeight: 字重',
                style:
                new TextStyle(fontWeight: FontWeight.w700, inherit: false),
              ),
              new Text(
                'fontWeight: 字小重',
                style:
                new TextStyle(fontWeight: FontWeight.w600, inherit: false),
              ),
              new Text(
                'fontWeight: 字正常',
                style:
                new TextStyle(fontWeight: FontWeight.w400, inherit: false),
              ),
              new Text(
                'fontStyle: FontStyle.italic 斜体',
                style:
                new TextStyle(fontStyle: FontStyle.italic, inherit: false),
              ),
              new Text(
                'letter Spacing: 字符间距',
                style: new TextStyle(letterSpacing: 10.0, inherit: false),
              ),
              new Text(
                'word Spacing: 字或单词间距',
                style: new TextStyle(inherit: false, wordSpacing: 15.0),
              ),
              new Text(
                'textBaseline:这一行的值为TextBaseline.alphabetic',
                style: new TextStyle(
                    inherit: false, textBaseline: TextBaseline.alphabetic),
              ),
              new Text(
                'textBaseline:这一行的值为TextBaseline.ideographic',
                style: new TextStyle(
                    inherit: false, textBaseline: TextBaseline.ideographic),
              ),
              buildPadding(),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: new Text('decoration: TextDecoration.overline 上划线',
                    style: new TextStyle(
                        inherit: false,
                        decoration: TextDecoration.overline,
                        decorationStyle: TextDecorationStyle.wavy)),
              ),
              new Text('decoration: TextDecoration.lineThrough 删除线',
                  style: new TextStyle(
                      inherit: false,
                      decoration: TextDecoration.lineThrough,
                      decorationStyle: TextDecorationStyle.dashed)),
              new Text('decoration: TextDecoration.underline 下划线',
                  style: new TextStyle(
                      inherit: false,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dotted)),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildPadding() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 12.0, right: 6.0),
      child: new Text(
          'height: 用在Text控件上的时候，会乘以fontSize做为行高,所以这个值不能设置过大,所以这个值不能设置过大,,所以这个值不能设置过大,所以这个值不能设置过大',
          style: new TextStyle(
            inherit: false,
            height: 3.0,
          )),
    );
  }
}


class TabbedAppBarSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
        length: choices.length,
          child: Builder(builder: (BuildContext co) {
            return buildScaffold(co);
          })
      ),
      routes: <String, WidgetBuilder>{
        Page.page_other_page: (BuildContext context) => new WidgetDemoPage(),
      },
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('TabBar+TabBarView'),
        centerTitle: false,
        actions: <Widget>[
          new IconButton( // action button
            icon: new Icon(Icons.timer),
            onPressed: () {
              showDatePicker(context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1990),
                  lastDate: DateTime(2200));
            },
          ),
          new IconButton( // action button
            icon: new Icon(Icons.ac_unit),
            onPressed: () {
              showAboutDialog(
                  context: context,
                  children: [
                    new Text("Child")
                  ]);
            },
          ),
          new IconButton( // action button
            icon: new Icon(Icons.dialpad),
            onPressed: () {
              showDialog(context: context, builder: (c) {
                return new AlertDialog(content: new Text("ShowDialog"),);
              });
            },
          ),
          new PopupMenuButton<Choice>( // overflow menu
            itemBuilder: (BuildContext context) {
              return choices.skip(2).map((Choice choice) {
                return new PopupMenuItem<Choice>(
                  value: choice,
                  child: new Text(choice.title),
                );
              }).toList();
            }, onSelected: (choice) {
            showDialog(context: context, builder: (c) {
              return new AlertDialog(
                content: new Text("choice ${choice.title}"),);
            });
          },)
        ],


        bottom: new TabBar(
          isScrollable: true,
          tabs: choices.map((Choice choice) {
            return new Tab(
              text: choice.title,
              icon: new Icon(choice.icon, color: Colors.red,),
            );
          }).toList(),
        ),
      ),
      body: new TabBarView(
        children: choices.map((Choice choice) {
          return new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new ChoiceCard(choice: choice),
          );
        }).toList(),
      ),
    );
  }
}

class Choice {
  const Choice({ this.title, this.icon });

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'CAR', icon: Icons.directions_car),
  const Choice(title: 'BICYCLE', icon: Icons.directions_bike),
  const Choice(title: 'BOAT', icon: Icons.directions_boat),
  const Choice(title: 'BUS', icon: Icons.directions_bus),
  const Choice(title: 'TRAIN', icon: Icons.directions_railway),
  const Choice(title: 'WALK', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({ Key key, this.choice }) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .display1;
    return new Card(
      color: Colors.white,
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Icon(choice.icon, size: 128.0, color: textStyle.color),
            new Text(choice.title, style: textStyle),
            new FlatButton(onPressed: () {
              Navigator.of(context).pushNamed(Page.page_other_page);
//              Navigator.of(context).pushNamed(Page.page_home_1);//当前的context只能打开当前
            }, child: new Text("page_other_page")),
            new RaisedButton(
              onPressed: () {
                final snackBar = new SnackBar(
                  content: new Text("Tip->${choice.title}"),
                  action: new SnackBarAction(
                      label: "Hide",
                      onPressed: () {
                        Scaffold.of(context).hideCurrentSnackBar();
                      }),
                );
                Scaffold.of(context).hideCurrentSnackBar(
                    reason: SnackBarClosedReason.hide);
                Scaffold.of(context).showSnackBar(snackBar);
              },
              child: new Text("显示Snackbar"),),
            new RaisedButton(
              onPressed: () {
                Scaffold.of(context).showBottomSheet((c) =>
                new Row(children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: 200.0,
                        color: Colors.black26,
                        child: new Text(
                          "${choice.title}",
                          textAlign: TextAlign.center,),
                      ))
                ],));
              },
              child: new Text("显示BottomSheetView"),),
          ],
        ),
      ),
    );
  }
}


class BasicWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Basic Widget"),
      ),
      body: new Builder(builder: (BuildContext context) {
        return new Column(
          children: <Widget>[
            new RaisedButton(
              onPressed: () {
                final snackBar = new SnackBar(
                  content: new Text("这是一个Snackbar"),
                  action: new SnackBarAction(
                      label: "Undo",
                      onPressed: () {

                      }),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              },
              child: new Text("显示Snackbar"),
            )
          ],
        );
      }),
    );
  }
}