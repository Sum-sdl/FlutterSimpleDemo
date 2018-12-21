import 'dart:async';

import 'package:flutter/material.dart';

class FlutterEventBus {
  Map<String, _Bus> _cacheBus;

  FlutterEventBus._() {
    _cacheBus = new Map();
  }

  Map<String, _Bus> get bus => _cacheBus;

  static FlutterEventBus _instance;

  static FlutterEventBus _getBus() {
    if (_instance == null) {
      _instance = new FlutterEventBus._();
    }
    return _instance;
  }

  static Map<String, _Bus> _getCacheBus() {
    return _getBus().bus;
  }

  //注册事件，必须和解除注册相对，不然界面关闭后，State会无法释放
  static void register(String key, Function onData) {
    var map = _getCacheBus();
    var bus = map[key];
    if (bus == null) {
      bus = _Bus();
      map[key] = bus;
    }
    bus.streamController.stream.listen(onData);
  }

  //解除事件监听
  static void unRegister(String key) {
    if (_getCacheBus().containsKey(key)) {
      _getCacheBus()[key].destroy();
      _getCacheBus().remove(key);
    }
  }

  static void sendValue(String key, dynamic data) {
    if (_getCacheBus().containsKey(key)) {
      _getCacheBus()[key].send(data);
    }
  }

  static void clearAll() {
    _getCacheBus().clear();
  }
}

class _Bus {
  StreamController _streamController;

  StreamController get streamController => _streamController;

  _Bus({bool sync: false}) {
    _streamController = new StreamController.broadcast(sync: sync);
  }

  Stream<T> on<T>() {
    if (T == dynamic) {
      return streamController.stream;
    } else {
      return streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  void send(event) {
    streamController.add(event);
  }

  void destroy() {
    _streamController.close();
  }
}

mixin AutoManagerEventBus<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    print("AutoManagerEventBus initState");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("AutoManagerEventBus deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("AutoManagerEventBus dispose");
  }

  @override
  Widget build(BuildContext context) {
    print("AutoManagerEventBus build");
    return null;
  }
}
