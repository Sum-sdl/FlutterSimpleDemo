import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_yshz/base.dart';
import 'package:flutter_yshz/net/base_net.dart';

class HomePageMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain>
    with BaseConfig, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => false;

  @override
  void initState() {
    super.initState();
    _refreshLoadData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Center(
          child: MaterialButton(
              onPressed: () {
                _refreshLoadData();
              },
              child: Text("Click Refresh")),
        ),
        onRefresh: _refreshLoadData);
  }

  Future<void> _refreshLoadData() {
    return _loadData();
  }

  Future<void> _loadData() async {
    Map<String, String> p = new Map();
    p["city"] = "nj";
    try {
      var rsp = await dio.get(Api.home, data: p);
      showToast(rsp.data["data"]["banner"][0]["b_img"].toString());
    } catch (e) {
      print(e);
    }
    setState(() {});
    return new Completer<Null>()..complete(null);
  }
}
