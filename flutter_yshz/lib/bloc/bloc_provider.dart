import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yshz/net/base_net.dart';

abstract class BlocBase {
  //网络请求
  @protected
  Dio get dio => DioFactory.getInstance().getDio();

  int pageIndex = 1;
  int pageSize = 20;

  Future<void> onRefreshTop() {
    pageIndex = 1;
    return onRefreshLoadData();
  }

  Future<void> onRefreshBottom() {
    pageIndex++;
    return onRefreshLoadData();
  }

  @protected
  Future<void> onRefreshLoadData() async {
    return new Completer<Null>()
      ..complete(null);
  }

  void initState();

  void dispose();
}

mixin AutoBlocMixin<T extends StatefulWidget> on State<T> {
  @protected
  BlocBase get bloc;

  @override
  void initState() {
    if (bloc != null) {
      bloc.initState();
    }
    super.initState();
    print("AutoBlocMixin initState ${this.toStringShort()}");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("AutoBlocMixin deactivate");
  }

  @override
  void dispose() {
    if (bloc != null) {
      bloc.dispose();
    }
    super.dispose();
    print("AutoBlocMixin dispose");
  }
}
