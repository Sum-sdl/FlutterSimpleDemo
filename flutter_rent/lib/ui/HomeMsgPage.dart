import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:image_picker/image_picker.dart';

class MsgView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print("MsgView build");
    return Scaffold(
        appBar: new AppBar(
          title: new Text("插件使用"),
        ),
        body: buildIntrinsicWidth(context));
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
        FlatButton(
          onPressed: () {
            ImagePicker.pickImage(
                source: ImageSource.camera,
                maxHeight: 200.0,
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
      ],
    );
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
