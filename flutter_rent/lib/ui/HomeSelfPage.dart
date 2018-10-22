import 'package:flutter/material.dart';

class SelfView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print("SelfView build");
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: new AppBar(
            centerTitle: true,
            title: new Text("我的房源"),
            bottom: new TabBar(
              tabs: [
                Tab(
                  text: '发',
                ),
                Tab(
                  text: '待审核',
                ),
                Tab(
                  text: '已下架了',
                ),
                Tab(
                  text: '未过',
                ),
              ],
              isScrollable: false,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.label,
            ),
          ),
          body: body()),
    );
  }

//  Widget body() {
//    print("SelfView build body");
//    return TabBarView(
//      children: <Widget>[
//        Card(
//          child: TabView("已发布"),
//          margin: EdgeInsets.all(0.0),
//        ),
//        Card(
//          child: TabView("待审核"),
//          margin: EdgeInsets.all(20.0),
//        ),
//        Card(
//          child: TabView("已下架"),
//          margin: EdgeInsets.all(40.0),
//          shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.all(Radius.circular(40.0))),
//        ),
//        Card(
//          child: TabView("未通过"),
//          margin: EdgeInsets.all(0.0),
//        ),
//      ],
//    );
//  }

  Widget body() {
    print("SelfView build body");
    return PageView.builder(itemBuilder: (c, i) {
      return TabView("$i");
    });
  }
}

//class TabView extends StatelessWidget {
//  final String tip;
//
//  const TabView(this.tip, {Key key}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    print("TabView build $tip");
//    return ListView.builder(itemCount: 100, shrinkWrap: false, itemBuilder: (c, i) {
//      print("$tip index->$i");
//      return Text("$tip index->$i");
//    });
//  }
//}
class TabView extends StatefulWidget {
  final String tip;

  const TabView(this.tip, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TabViewState();
}

class TabViewState extends State<TabView> {

//  GlobalObjectKey key;

  GlobalKey key2 = new GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("TabViewState didChangeDependencies ${widget.tip}");
  }

  @override
  void initState() {
    super.initState();
    print("TabViewState initState ${widget.tip}");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("TabViewState deactivate ${widget.tip}");
  }

  @override
  void dispose() {
    super.dispose();
    print("TabViewState dispose ${widget.tip}");
  }

  @override
  void didUpdateWidget(TabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    print(
        "TabViewState didUpdateWidget old:${oldWidget.tip},new ${widget.tip}");
  }

  @override
  Widget build(BuildContext context) {
    print("TabViewState build ${widget.tip}");
    return buildListView();
  }

  ListView buildListView() {
    return ListView.builder(
        key: key2,
        itemCount: 100, shrinkWrap: false, itemBuilder: (c, i) {
      return Text("${widget.tip} index->$i");
    });
  }
}