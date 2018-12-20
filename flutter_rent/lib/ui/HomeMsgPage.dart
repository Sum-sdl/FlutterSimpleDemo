import 'package:flutter/material.dart';
import 'package:flutter_rent/flutter_sender.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class MsgView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MsgState();
}

class MsgState extends State<MsgView>
    with WidgetsBindingObserver, TickerProviderStateMixin {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("第三方库调用以及常用功能测试"),
        ),
        body: content(context));
  }

  String changeText = "";
  AnimationController _animationController;

  @override
  void initState() {
    controller = VideoPlayerController.network(
        'https://video.pc6.com/v/1807/hsxspzmpxinxg.mp4');

    _animationController = new AnimationController(
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
      duration: const Duration(milliseconds: 3000),)
      ..addListener(() {
        setState(() {
          changeText = _animationController.value.toString();
        });
      });


    super.initState();
  }

  Widget content(BuildContext c) {
    return Column(children: <Widget>[
      Text(changeText),
      FlatButton(
        onPressed: () {
          Tween<double>(begin: 1, end: 10).animate(_animationController)
            ..addListener(() {
              print(_animationController.value);
            });
          _animationController.reset();
          _animationController.forward();
        },
        child: Text("Tween动画"),
      ),

      buildIntrinsicWidth(c),
    ],);
  }

  Widget buildIntrinsicWidth(BuildContext c) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.end,
      children: <Widget>[
        Container(
            color: Colors.yellow,
            width: 280.0,
            height: 40.0,
            child: Center(
              child: FlatButton(
                onPressed: () {
                  ImagePicker.pickImage(
                      source: ImageSource.gallery,
                      maxHeight: 200.0,
                      maxWidth: 200.0)
                      .then((file) {
                    print(file);
                  });
                },
                child: Text("选择图片"),
              ),
            )),
        Container(
            color: Colors.blue,
            width: 200.0,
            height: 60.0,
            child: Center(
              child: FlatButton(
                onPressed: () {
                  FlutterPlugin.showImageChoose(7);
                },
                child: Text(
                  "自定义Activity界面，多选图片7涨",
                  style: TextStyle(color: Colors.white),),
              ),
            )),
        FlatButton(
          color: Colors.orange,
          onPressed: () {
            ImagePicker.pickImage(
                source: ImageSource.camera,
                maxHeight: 400.0,
                maxWidth: 200.0)
                .then((file) {
              print(file);
            });
          },
          child: Text("拍照"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(c).push(MaterialPageRoute(builder: (c) =>
                CommonWebView("网页", "https://flutterchina.club/ios-release/")));
          },
          child: Text("网页"),
        ),

        FlatButton(
          onPressed: () {

          },
          child: Text("获取文件路径"),
        ),


//        Container(
//            color: Colors.black12,
//            width: MediaQuery
//                .of(c)
//                .size
//                .width,
//            height: 200,
//            child: new Chewie(controller)
//        ),

      ],
    );
  }

  VideoPlayerController controller;


  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    _animationController.dispose();
    super.dispose();
  }
}


class CommonWebView extends StatefulWidget {
  final String title;

  final String url;

  CommonWebView(this.title, this.url);

  @override
  State<StatefulWidget> createState() {
    return new _CommonWebViewPageState();
  }
}


class _CommonWebViewPageState extends State<CommonWebView> {

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      withZoom: true,
      withLocalStorage: true,
      bottomNavigationBar: Container(
        color: Colors.blue,
        width: 100.0,
        child: new SizedBox(
          width: 200.0,
          height: 30.0,
          child: Text("BottomNabar", style: TextStyle(color: Colors.black),),),
      ),
    );
  }
}
