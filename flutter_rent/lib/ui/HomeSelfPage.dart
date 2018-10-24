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

  Widget body() {
    print("SelfView build body");
    return TabBarView(
      children: <Widget>[
        Card(
          child: TabView("已发布"),
          margin: EdgeInsets.all(0.0),
        ),
        Card(
          child: TabView("待审核"),
          margin: EdgeInsets.all(20.0),
        ),
        Card(
          child: TabView("已下架"),
          margin: EdgeInsets.all(40.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0))),
        ),
        Card(
          child: TabView("未通过"),
          margin: EdgeInsets.all(0.0),
        ),
      ],
    );
  }

//  Widget body() {
//    print("SelfView build body");
//    return PageView.builder(itemBuilder: (c, i) {
//      return TabView("$i");
//    });
//  }
}

class TabView extends StatefulWidget {
  final String tip;

  const TabView(this.tip, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TabViewState();
}

class TabViewState extends State<TabView> with AutomaticKeepAliveClientMixin,TickerProviderStateMixin {

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
  void deactivate() {//类似stop
    super.deactivate();
    print("TabViewState deactivate ${widget.tip}");
  }

  @override
  void dispose() {//类似destory
    super.dispose();
    print("TabViewState dispose ${widget.tip}");
  }

  @override
  void didUpdateWidget(TabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    print(
        "TabViewState didUpdateWidget old:${oldWidget.hashCode},new ${widget
            .hashCode}");
  }

  @override
  Widget build(BuildContext context) {
    print("TabViewState build ${widget.tip}");
    return buildListView();
//    return new Swiper(
//      itemBuilder: (BuildContext context, int index) {
//        return new Image.network(
//          "http://via.placeholder.com/350x150", fit: BoxFit.fill,);
//      },
//      itemCount: 3,
//      pagination: new SwiperPagination(),
//    );
  }

  ListView buildListView() {
    return ListView.builder(
        itemCount: 100, shrinkWrap: false, itemBuilder: (c, i) {
//      print("${widget.tip} index->$i");
      return Text("${widget.tip} index->$i");
    });
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}