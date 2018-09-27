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
  String dataText = "";

  _click() {
    setState(() {
      index++;
    });
  }

  _netDataChange(String data) {
    setState(() {
      dataText = data;
    });
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
              maxLines: 2,
            ),
            new MaterialButton(
              onPressed: () {
                _click();
              },
              child: new Text("主线程点击->${index + 1}"),
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
          ],
        ),
      ),
    );
  }

  _threadTest() {
    print("Thread Test Start");
  }

  //async 异步操作
  _netTest() async {
    print("NetWork Test Start");
    setState(() {
      _netDataChange("网络请求开始");
    });
    String dataURL = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dataURL);
    setState(() {
      _netDataChange("网络请求结束->${response.body}");
    });
    print("rsp->${response.body}");
    print("NetWork Test End");
  }
}
