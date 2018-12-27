import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yshz/net/base_net.dart';
import 'package:flutter_yshz/resource.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BaseConfig {
  //网络请求
  @protected
  Dio get dio => DioFactory.getInstance().getDio();

  //加载组件
  Widget showLoadingWidget() {
    return Center(child: CircularProgressIndicator());
  }

  //加载组件
  Widget showErrorWidget() {
    return Center(child: Text("网络异常"));
  }

  Widget showNetImageWidgetImgError(String url) {
    return showNetImageWidgetImgCustom(url, ResImages.image_error);
  }

  Widget showNetImageWidgetImgCustom(String url, String imgRes) {
    if (url == null || url.length == 0) {
      return Image.asset(imgRes);
    }
    return CachedNetworkImage(
      imageUrl: url,
      fadeInDuration: const Duration(milliseconds: 300),
      placeholder: Image.asset(
        ResImages.image_error,
        fit: BoxFit.cover,
      ),
      errorWidget: Image.asset(imgRes, fit: BoxFit.cover),
      fit: BoxFit.fill,
    );
  }

  Widget showNetImageWidgetGreyColor(String url) {
    if (url == null || url.length == 0) {
      return Container(color: ResColors.color_grey);
    }
    return CachedNetworkImage(
      imageUrl: url,
      fadeInDuration: const Duration(milliseconds: 300),
      placeholder: Container(color: ResColors.color_grey),
      errorWidget: Container(color: ResColors.color_grey),
      fit: BoxFit.fill,
    );
  }

  //提示
  void toastShow(String msg) {
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
