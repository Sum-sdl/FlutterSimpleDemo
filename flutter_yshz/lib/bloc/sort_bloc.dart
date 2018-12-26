import 'dart:async';

import 'package:flutter_yshz/bloc/bloc_provider.dart';
import 'package:flutter_yshz/net/base_net.dart';

class SortBloc extends BlocBase {
  StreamController _controller = new StreamController<SortBean>();

  SortBloc(this.hasChild);

  Stream<SortBean> get stream => _controller.stream;

  final bool hasChild;

  @override
  void dispose() {
    _controller.close();
  }

  @override
  void initState() {
    print("hasChild ->$hasChild");
    loadData();
  }

  Future<void> loadData() async {
    Map<String, String> p = new Map();
    p["city"] = "nj";
    try {
      var rsp = await dio.get(Api.home, data: p);
      SortBean bean = SortBean.fromMap(rsp.data["data"]);
      _controller.sink.add(bean);
    } catch (e) {
      print(e);
    }
    return new Completer<Null>()..complete(null);
  }
}

class SortBean {
  List<dynamic> banner;
  List<dynamic> sorts;
  dynamic news;

  SortBean.fromMap(Map<String, dynamic> data) {
    banner = data["banner"];
    sorts = data["sorts"];
    news = data["news"];
  }
}
