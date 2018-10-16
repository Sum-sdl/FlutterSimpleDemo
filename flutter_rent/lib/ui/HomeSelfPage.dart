import 'package:flutter/material.dart';

class SelfView extends StatelessWidget {
  const SelfView();

  @override
  Widget build(BuildContext context) {
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
          child: Center(child: Text("已发布")),
          margin: EdgeInsets.all(0.0),
        ),
        Card(
          child: Center(child: Text("待审核")),
          margin: EdgeInsets.all(20.0),
        ),
        Card(
          child: Center(child: Text("已下架")),
          margin: EdgeInsets.all(40.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0))),
        ),
        Card(
          child: Center(child: Text("未通过")),
        ),
      ],
    );
  }
}
