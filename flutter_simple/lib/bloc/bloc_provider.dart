import 'dart:async';

import 'package:rxdart/subjects.dart';

class BlocProvider {
  //stream的多监听使用broadcast
  // 首次监听，初始值不会触发回调;在第二次监听的时候，值不会通知给新的注册者
//  var _controller = new StreamController<int>.broadcast();

  //rxDart 的使用

  //publish测试
  // 跟默认StreamController<int>.broadcast()更能一致
//  var _controller = new PublishSubject<int>();

  //behavior测试
  // 首次监听，初始值不会触发回调;在第二次监听的时候，值会更新给新的注册者
  var _controller = new BehaviorSubject<int>();

// 跟BehaviorSubject 功能类似
//  var _controller = new ReplaySubject<int>();

  int _count = 1;

  Stream<int> get intStream => _controller.stream;

  void dispose() {
    if (!_controller.isClosed) {
      _controller.close();
    }
  }

  //模拟添加监听
  void test() {
    intStream.listen((data) {
      print("onChange->$data");
    }, onError: (e) {
      print(e);
    }, onDone: () {
      print("onDone,$_count");
    });
  }

  void testEvent(){
  }

  //模拟值变动
  void addCount() {
    _count++;
    _controller.sink.add(_count);
  }
}
