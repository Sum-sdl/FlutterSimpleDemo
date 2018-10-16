import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MsgView extends StatelessWidget {
  const MsgView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("插件使用"),
        ),
        body: buildIntrinsicWidth());
  }

  Widget buildIntrinsicWidth() {
    return Column(
      children: <Widget>[
        Container(
            color: Colors.yellow,
            width: double.infinity,
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
      ],
    );
  }
}
