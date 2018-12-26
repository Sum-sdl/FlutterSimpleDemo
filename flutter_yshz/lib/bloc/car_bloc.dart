import 'dart:async';

import 'package:flutter_yshz/bloc/bloc_provider.dart';
import 'package:flutter_yshz/net/base_net.dart';

class CarBloc extends BlocBase {
  StreamController _controller = new StreamController<CarBean>();

  Stream<CarBean> get stream => _controller.stream;

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
      CarBean bean = CarBean.fromMap(rsp.data["data"]);
      _controller.sink.add(bean);
    } catch (e) {
      print(e);
    }
    return new Completer<Null>()..complete(null);
  }
}

class CarBean {
  List<dynamic> banner;
  List<dynamic> sorts;
  dynamic news;

  CarBean.fromMap(Map<String, dynamic> data) {
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
