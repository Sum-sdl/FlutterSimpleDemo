import 'dart:async';

import 'package:flutter_yshz/bloc/bloc_provider.dart';
import 'package:flutter_yshz/net/base_net.dart';

class SortBloc extends BlocBase {

  StreamController _controller = new StreamController();

  SortBloc(this.id, {this.type = 0, this.hasChild});

  Stream get stream => _controller.stream;

  final bool hasChild;
  final String id;
  final int type;

  //商品
  List<Good> _goods = new List();

  @override
  void dispose() {
    _controller.close();
  }

  @override
  void initState() {
    if (type == 0) {
      onRefreshLoadData();
    } else if (type == 1) {
      _loadGoodDetails();
    }
  }

  @override
  onRefreshLoadData() {
    return _loadData();
  }

  _loadGoodDetails() async {
    Map<String, String> p = new Map();
    p["id"] = id;
    try {
      var rsp = await dio.get(Api.sort_list_good_details, data: p);
      Good bean = Good.fromJson(rsp.data["data"]);
      _controller.sink.add(bean);
    } catch (e) {
      _controller.sink.add(e);
      print(e);
    }
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
      if (page == 1) {
        _goods.clear();
      }
      _goods.addAll(bean.goods);
      bean.goods = _goods;

      _controller.sink.add(bean);
    } catch (e) {
      print(e);
    }
  }
}

class SortBean {
  //分类
  List<Adv> adv;

  //商品
  List<Good> goods;

  SortBean.fromMap(Map<String, dynamic> data) {
    var sort = data["list"] as List;
    if (sort != null) {
      this.goods = sort.map((sort) {
        return Good.fromJson(sort);
      }).toList();
    }

    var adv = data["adv"] as List;
    if (adv != null) {
      this.adv = adv.map((item) {
        return Adv.formJson(item);
      }).toList();
    }
  }
}

class Adv {
  String bImg;
  String jumpId;
  String sortId;
  int jumpType = 1;

  Adv.formJson(Map<String, dynamic> data) {
    bImg = data["b_img"];
    jumpId = data["jumpid"].toString();
    sortId = data["sortid"].toString();
    jumpType = data["jump_type"];
  }
}

class Good {

  //分类
  int id;
  String name;
  String img;
  int hasChild = 0;

  List<dynamic> imgList = const[];

  String city;
  String subtitle;
  int buynum;
  int soldnum;
  String price;
  int status;
  String unit;
  String desc;

  String tel_code;
  String tel_main;
  String tel_ext;
  String s_address;
  String s_phone;

  Good.fromJson(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
    hasChild = data["hasChild"];

    var img = data["img"];
    if (img is String) {
      img = img;
    } else if (img is List) {
      imgList = img;
    }
    subtitle = data["subtitle"];
    desc = data["desc"];
    status = data["status"];
    soldnum = data["soldnum"];
    buynum = data["buynum"];
    price = data["price"].toString();
    unit = data["unit"].toString();
  }
}
