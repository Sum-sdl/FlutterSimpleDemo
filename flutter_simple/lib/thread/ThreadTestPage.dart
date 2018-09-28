import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ThreadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ThreadTestState();
  }
}

class _ThreadTestState extends State<ThreadPage> {
  int index = 0;
  int index2 = 11;
  String dataText = "";

  _click() {
    index2++;
    setState(() {
      index++;
    });
  }

  _netDataChange(String data) {
    /*setState(() {
      dataText = data;
    });*/
    dataText = data;
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("线程相关测试"),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            new Text(
              dataText,
              maxLines: 8,
              style: new TextStyle(color: Colors.blueAccent, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            new MaterialButton(
              onPressed: () {
                _click();
              },
              child: new Text("主线程点击->${index + 1}->${index2 + 1}"),
            ),
            new MaterialButton(
              onPressed: () {
                _threadTest();
              },
              child: new Text("启动异步线程"),
            ),
            new MaterialButton(
              onPressed: () {
                _netTest();
              },
              child: new Text("网络请求"),
            ),

            new MaterialButton(
              onPressed: () {
                _ioDartTest();
              },
              child: new Text("IO库的网络请求"),
            ),
            new MaterialButton(
              onPressed: () {
                _test();
              },
              child: new Text("回调 Test"),
            ),
            new MaterialButton(
              onPressed: () {
                _test2();
              },
              child: new Text("回调 Test2"),
            ),
          ],
        ),
      ),
    );
  }

  _threadTest() {
    print("Thread Test Start");
  }



  ///https://flutterchina.club/networking/
  ///部分变更
  _ioDartTest() async {
    print("NetWork IO Test Start");
    setState(() {
      _netDataChange("IO网络请求开始");
    });

    var url = 'https://httpbin.org/ip';
    var httpClient = new HttpClient();

    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var d = await response.transform(utf8.decoder).join();
        var data = json.decode(d, reviver: (a, b) {
          print("$a->$b");
        });
        result = data['origin'];
      } else {
        result =
        'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting IP address';
    }
    setState(() {
      _netDataChange("result->" + result);
    });
    print("NetWork IO Test End");
  }


  //async 异步操作
  _netTest() async {
    print("NetWork Test Start");
    setState(() {
      _netDataChange("网络请求开始");
    });
    String dataURL = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dataURL);
    int index = 0;
    var data = json.decode(response.body);
    /* var data = json.decode(response.body, reviver: (a, b) {
      if (a!=null) {
        print("${++index}->$a:$b");
      }
    });*/

    setState(() {
      _netDataChange("网络请求结束->${data[0]["id"]}+${data[0]["title"]}");
    });
    print("rsp->${response.body}");
    print("NetWork Test End");
  }


  _test() {
    var callbacks = [];
    for (var i = 0; i < 3; i++) {
      // 在列表 callbacks 中添加一个函数对象，这个函数会记住 for 循环中当前 i 的值。
      callbacks.add((String text) => print('Save $i ,' + text));
    }
    callbacks.forEach((c) => c("index->" + index2.toString()));
    callbacks.forEach((x) {
      x("0");
      x("1");
      return x("2");
    });
  }

  _test2() {
//    Future f1 = new Future(() => null);
//    Future f2 = new Future(() => null);
//    Future f3 = new Future(() => null);
//
//    f3.then((_) => print("f3 then"));
//
//    f2.then((_) {
//      print("f2 then");
//      new Future(() => print("new Future befor f1 then"));
//      f1.then((_) {
//        print("f1 then");
//      });
//    });
  }
}
