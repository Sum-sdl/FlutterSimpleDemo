import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yshz/net/base_net.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BaseConfig {
  //网络请求
  Dio dio = DioFactory.getInstance().getDio();

  //加载组件
  Widget showLoading() {
    return Center(child: CircularProgressIndicator());
  }

  //提示
  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.transparent);
  }

  // 状态栏
  double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  //进度比例计算
  double getProgressPercent(int value, int target) {
    if (value == target) {
      return 1;
    }
    double progress = (value - target) / (target);
    double curProgress = max(progress, 0);
    return min(curProgress, 1);
  }

  //
  bool isEmpty(String text) {
    return null == text || text.length == 0;
  }
}
