import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPlugin {
  static const String plugin_name = "sum.flutter.utils/device";

  static const String _fun_getPlatformVersion = "getPlatformVersion";
  static const String _fun_getAppUniqueUUID = "getAppUniqueUUID";
  static const String _fun_showToast = "showToast";

  static const MethodChannel _channel = const MethodChannel(plugin_name);

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod(_fun_getPlatformVersion);
    return version;
  }

  static Future<String> get getAppUniqueUUID async {
    return await _channel.invokeMethod(_fun_getAppUniqueUUID);
  }

  static Future<String> showToast(String msg) async {
    var map = Map<String, Object>();
    map["msg"] = msg;
    map["index"] = 1;
    return await _channel.invokeMethod(_fun_showToast, map);
  }
  static showImageChoose(int num) async {
    var map = Map<String, Object>();
    map["num"] = num;
    return await _channel.invokeMethod("choose_image", map);
  }
}
