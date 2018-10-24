import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rent/net/Api.dart';
import 'package:flutter_rent/net/DioFactory.dart';
import 'package:flutter_rent/widget/HouseInfoWidget.dart';

class HouseListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HouseListViewState();
  }
}

class _HouseListViewState extends State<HouseListView> with AutomaticKeepAliveClientMixin{
  List<HouseInfoBean> houseWidget = [];

  showLoadingDialog() {
    if (houseWidget.length == 0) {
      return true;
    }
    return false;
  }

  getProgressDialog() {
    return new Center(child: new CircularProgressIndicator());
  }

  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return ListView.separated(
        itemCount: houseWidget.length,
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemBuilder: (c, index) {
//          print("house list build $index");
          return new HouseInfoWidget(houseWidget[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 2.0,
            color: Colors.blue,
          );
        },
      );
    }
  }

  ScrollController _scrollController;

  int page = 1;

  _scroll() {
//    print(
//        '${_scrollController.position.pixels},${_scrollController.position
//            .maxScrollExtent}');
    if (_scrollController.position.pixels + 300 >=
        _scrollController.position.maxScrollExtent) {
      page++;
      _loadData();
    }
  }

  @override
  void initState() {
    _scrollController = new ScrollController(
        initialScrollOffset: 10.0, keepScrollOffset: true);
    _scrollController.addListener(_scroll);
    _refreshLoadData();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("HouseListView build");
    return RefreshIndicator(
      onRefresh: _refreshLoadData,
      child: getBody(),
    );
  }

  Future<Null> _refreshLoadData() {
    page = 1;
    return _loadData();
  }

  Future<Null> _loadData() async {
    Map<String, String> p = new Map();
    p["page"] = page.toString();
    p["perpage"] = "22";
    p["city"] = "nj";
    Dio dio = DioFactory.getInstance().getDio();
    dio.options.data = p; //请求参数
    try {
      var response = await dio.get(Api.list);
      var data = response.data;
      if (data["code"] == 1) {
        //房源
        if (page == 1) {
          houseWidget.clear();
        }
        var house = data["data"]["data"] as List<dynamic>;
        house.forEach((it) => houseWidget.add(HouseInfoBean.fromJson(it)));
      } else if (data["code"] == -996) {
        _loadData();
      }
    } catch (e) {
      print(e);
    }
    setState(() {});
    var c = new Completer<Null>();
    c.complete(null);
    return c.future;
  }

  @override
  bool get wantKeepAlive => true;
}
