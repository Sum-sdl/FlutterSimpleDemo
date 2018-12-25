import 'dart:async';

import 'package:flutter_yshz/bloc/bloc_provider.dart';
import 'package:flutter_yshz/net/base_net.dart';

class HomeBloc extends BlocBase {
  StreamController _controller = new StreamController<HomeBean>();

  Stream<HomeBean> get stream => _controller.stream;

  @override
  void dispose() {
    _controller.close();
  }

  @override
  void initState() {
    loadData();
  }

  Future<void> loadData() async {
    Map<String, String> p = new Map();
    p["city"] = "nj";
    try {
      var rsp = await dio.get(Api.home, data: p);
      HomeBean bean = HomeBean.fromMap(rsp.data["data"]);
      _controller.sink.add(bean);
    } catch (e) {
      print(e);
    }
    return new Completer<Null>()..complete(null);
  }
}

class HomeBean {
  List<dynamic> banner;
  List<dynamic> sorts;
  dynamic news;

  HomeBean.fromMap(Map<String, dynamic> data) {
    banner = data["banner"];
    sorts = data["sorts"];
    news = data["news"];
  }
}

class HomeOpSort {
  String id;
  String name;
  String img;
}
