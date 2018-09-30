import 'package:flutter/material.dart';
import 'package:flutter_rent/ui/HomePage.dart';
import 'package:flutter_rent/ui/MsgPage.dart';
import 'package:flutter_rent/ui/SelfPage.dart';

void main() => runApp(new MyApp());

class Page {
  static String page_1 = "page_1";
  static String page_2 = "page_2";
  static String page_3 = "page_3";
  static String page_4 = "page_4";
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    print("_HomePage createState");
    return new _HomeState();
  }
}

class _HomeState extends State<_HomePage> {
  List<Widget> _pages;
  int _curPage = 0;

  List<ChooseItem> items;

  _itemClick(ChooseItem item) {
    print("click item -> ${item.title}");
    setState(() {
      if (_curPage != item.index) {
        _curPage = item.index;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    items = <ChooseItem>[
      new ChooseItem(0, "首页", Icons.home, choose: true, callback: _itemClick),
      new ChooseItem(1, "收藏", Icons.collections, callback: _itemClick),
      new ChooseItem(2, "消息", Icons.message, callback: _itemClick),
      new ChooseItem(3, "我的", Icons.account_box, callback: _itemClick),
    ];
    _pages = new List();
    _pages
      ..add(new HomeView())
      ..add(new MsgView())
      ..add(new SelfView())
      ..add(new HomeView());
  }

  @override
  Widget build(BuildContext context) {
    print("_HomeState build->${_curPage + 0}");
    return new Scaffold(
        body: _pages[_curPage],
        backgroundColor: Colors.black26,
        bottomNavigationBar: BottomAppBar(
          child: Row(children: <Widget>[
            new ChoiceView(item: items[0]),
            new ChoiceView(item: items[1]),
            new ChoiceView(item: items[2]),
            new ChoiceView(item: items[3]),
          ]),
        ));
  }
}

class ChoiceView extends StatefulWidget {
  final ChooseItem item;

  const ChoiceView({Key key, this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _ChoiceViewState();
}

class _ChoiceViewState extends State<ChoiceView> {
  bool isChoose = false;

  @override
  void initState() {
    super.initState();
    isChoose = widget.item.choose;
  }

  _changeState() {
    setState(() {
      isChoose = !isChoose;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(child: content());
  }

  Widget content() {
    return new InkResponse(
      onTap: () {
//        print("${widget.item.title} onTap");
        //没类型需要动态，定义typedef 回调，类型固定,
        widget.item.function(widget.item);
        _changeState();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              widget.item.icon,
              color: isChoose ? widget.item.selColor : widget.item.norColor,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                widget.item.title,
                style: TextStyle(
                    fontSize: 10.0,
                    color:
                        isChoose ? widget.item.selColor : widget.item.norColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//定义好Callback固定类型
typedef _ItemClickCallback(ChooseItem item);

class ChooseItem {
  ChooseItem(
    this.index,
    this.title,
    this.icon, {
    this.choose = false,
    this.norColor = Colors.black,
    this.selColor = Colors.orangeAccent,
    callback(ChooseItem i),
  }) {
    function = callback;
  }

  final int index;
  final String title;
  final Color norColor;
  final Color selColor;
  final IconData icon;
  final bool choose;
  Function function;
}
