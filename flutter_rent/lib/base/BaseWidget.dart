import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rent/net/DioFactory.dart';
import 'package:flutter_rent/widget/common_share.dart';

class BaseConfig {
  //网络请求
  Dio dio = DioFactory.getInstance().getDio();

  //加载组件
  Widget loadingWidget() {
    return Center(child: CircularProgressIndicator());
  }

  //show
  showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).removeCurrentSnackBar();
    final snackBar = new SnackBar(content: new Text(text));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  showSnackBarByKey(final GlobalKey<ScaffoldState> key, String text) {
    final snackBar = new SnackBar(content: new Text(text));
    key.currentState.removeCurrentSnackBar();
    key.currentState.showSnackBar(snackBar);
  }

  showAppShare(BuildContext context) {
    CommonShare.buildShareBottomPop(context);
  }

  // 状态栏
  getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  //进度比例计算
  getProgressPercent(int curValue, int target) {
    return _progressPercent(curValue, target);
  }

  double _progressPercent(int value, int target) {
    if (value == target) {
      return 1;
    }
    double progress = (value - target) / (target);
    double curProgress = max(progress, 0);
    return min(curProgress, 1);
  }

  //
  isEmpty(String text) {
    return null == text || text.length == 0;
  }
}
