import 'package:FlutterSimple/eventbus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new EventState();
  }
}

class EventState extends State<EventTest> with AutoManagerEventBus{
  String changeText = "start";
  int count = 0;

  @override
  void initState() {
    FlutterEventBus.register("key", (e) {
      print("back->$e");
      setState(() {
        changeText = e;
      });
    });
    super.initState();
    print("initState");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    FlutterEventBus.unRegister("key");
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    print("EventState build $count");
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Flutter EventBus测试"),
        ),
        body: Column(
          children: <Widget>[
            Text(changeText),
            FlatButton(
                onPressed: () {
                  FlutterEventBus.sendValue("key", " click->${++count}");
                },
                child: Text("发送事件")),
            FlatButton(
                onPressed: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (c) {
                    return _Event2Page();
                  }));
                },
                child: Text("第二页")),
          ],
        ));
  }
}

class _Event2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Event第二页"),
      ),
      body: buildContent(),
    );
  }

  Widget buildContent() {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            FlutterEventBus.sendValue(
                "key", " second ui send data-> ${TimeOfDay.now().toString()}");
          },
          child: Container(
              width: double.infinity,
              color: Colors.blue,
              height: 50.0,
              child: Center(
                  child: Text(
                "点击发送值",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ))),
        ),
      ],
    );
  }
}
