import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yshz/resource.dart';
import 'package:flutter_yshz/ui/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: ResColors.colorPrimary,
      ),
      home: _SplashPage(),
    );
  }
}

class _SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //延迟加载
    new Timer.periodic(Duration(seconds: 2), (timer) {
      timer.cancel();
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (c) {
        return HomePage();
      }), (route) => route == null);
    });

    return Container(
      color: Colors.white,
      child: Center(
        child: FlatButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(context,
                  CupertinoPageRoute(builder: (c) {
                return HomePage();
              }), (route) => route == null);
            },
            child: Text("点击跳转")),
      ),
    );
  }
}
