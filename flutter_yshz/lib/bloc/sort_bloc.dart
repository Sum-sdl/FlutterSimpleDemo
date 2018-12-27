import 'dart:async';

import 'package:flutter_yshz/bloc/bloc_provider.dart';
import 'package:flutter_yshz/net/base_net.dart';

class SortBloc extends BlocBase {
  StreamController _controller = new StreamController<SortBean>();

  SortBloc(this.hasChild, this.id, {this.type});

  Stream<SortBean> get stream => _controller.stream;

  final bool hasChild;
  final String id;
  final int type;

  @override
  void dispose() {
    _controller.close();
  }

  @override
  void initState() {
    if (type == 0) {
      onRefreshLoadData();
    }
  }

  @override
  onRefreshLoadData() {
    return _loadData();
  }

  Future<void> _loadData() async {
    if (hasChild) {
      await _loadSort();
    } else {
      await _loadGoods(pageIndex);
    }
    return new Completer<Null>()..complete(null);
  }

  _loadSort() async {
    Map<String, String> p = new Map();
    p["id"] = id;
    try {
      var rsp = await dio.get(Api.sort_list, data: p);
      SortBean bean = SortBean.fromMap(rsp.data["data"]);
      _controller.sink.add(bean);
    } catch (e) {
      print(e);
    }
  }

  _loadGoods(int page) async {
    var p = new Map<String, dynamic>();
    p["sortid"] = id;
    p["page"] = page;
    p["pagesize"] = pageSize;
    try {
      var rsp = await dio.get(Api.sort_list_good, data: p);
      SortBean bean = SortBean.fromMap(rsp.data["data"]);
      _controller.sink.add(bean);
    } catch (e) {
      print(e);
    }
  }
}

class SortBean {
  List<dynamic> secondSort;

  SortBean.fromMap(Map<String, dynamic> data) {
    secondSort = data["secondSort"];
  }
}

class SortItem {
  int id;
  String name;
  String img;
  int pid;
  int hasChild = 0;
}
