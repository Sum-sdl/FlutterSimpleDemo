import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yshz/net/base_net.dart';

abstract class BlocBase {
  //网络请求
  @protected
  Dio get dio => DioFactory.getInstance().getDio();

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
