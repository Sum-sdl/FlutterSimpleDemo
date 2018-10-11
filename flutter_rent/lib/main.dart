import 'package:flutter/material.dart';
import 'package:flutter_rent/ui/HomeHouseLIstPage.dart';
import 'package:flutter_rent/ui/HomeMsgPage.dart';
import 'package:flutter_rent/ui/HomePage.dart';
import 'package:flutter_rent/ui/HomeSelfPage.dart';

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
    print("MyApp build");
    return new MaterialApp(
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
    print("click item bar -> ${item.title},${item.index}");
    setState(() {
      if (_curPage != item.index) {
        _curPage = item.index;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print("_HomePage initState");
    items = <ChooseItem>[
      new ChooseItem(0, "首页", Icons.home, choose: true, callback: _itemClick),
      new ChooseItem(1, "房源", Icons.collections, callback: _itemClick),
      new ChooseItem(2, "消息", Icons.message, callback: _itemClick),
      new ChooseItem(3, "我的", Icons.account_box, callback: _itemClick),
    ];
    _pages = new List();
    _pages.add(new HomeView());
    _pages.add(new HouseListView());
    _pages.add(new MsgView());
    _pages.add(new SelfView());
  }

  @override
  Widget build(BuildContext context) {
    print("_HomeState build $_curPage");
    return Scaffold(
        body: IndexedStack(index: _curPage, children: _pages,),
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomAppBar(
            child: BottomBarParent(
              items: items, defaultChooseItem: items[_curPage],)));
  }
}

//管理一组底部按钮的单选状态
class BottomBarParent extends StatefulWidget {
  final List<ChooseItem> items;
  final ChooseItem defaultChooseItem; //默认选项

  const BottomBarParent({Key key, this.items, this.defaultChooseItem})
      : super(key: key);

  @override
  _BottomBarParentState createState() {
    print("BottomBarParent createState ${defaultChooseItem.index}");
    return new _BottomBarParentState(defaultChooseItem);
  }
}

/// BottomBarParent 重新new了，但是createState没走, _BottomBarParentState没new ！why？
class _BottomBarParentState extends State<BottomBarParent> {

  ChooseItem curItem; //默认选项

  _BottomBarParentState(this.curItem) {
    print("_BottomBarParentState new ${curItem.index}");
  }

  //bar点击的
  _itemBarClick(ChooseItem item) {
    if (curItem != item) {
      curItem.choose = false;
      item.choose = true;
      item.callback(item);
      setState(() {
        curItem = item;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("_BottomBarParentState build ${curItem.index}");
    return new Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.items.map((item) {
          return BottomBarItem(item: item, itemBarClick: _itemBarClick,);
        }).toList());
  }
}

class BottomBarItem extends StatelessWidget {
  final ChooseItem item;
  final Function itemBarClick;

  const BottomBarItem({Key key, this.item, this.itemBarClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) => barItem();

  Widget barItem() {
    return new InkResponse(
      //没类型需要动态，定义typedef 回调，类型固定,
      onTap: () {
        itemBarClick(item);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              item.icon,
              color: item.choose ? item.selColor : item.norColor,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                item.title,
                style: TextStyle(
                    fontSize: 10.0,
                    color:
                    item.choose ? item.selColor : item.norColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChooseItem {
  ChooseItem(
    this.index,
    this.title,
    this.icon, {
    this.choose = false,
    this.norColor = Colors.black,
    this.selColor = Colors.orangeAccent,
        this.callback,
      });
  final int index;
  final String title;
  final Color norColor;
  final Color selColor;
  final IconData icon;
  final Function callback;
  bool choose;
}
