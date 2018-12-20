import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rent/ui/HouseOtDetailsPage.dart';

class RouteHelper {
//  static route2Detail(BuildContext context, String houseId, String roomId,
//  {String url}) {
//    if (null == houseId) {
//      return;
//    }
//    Navigator.of(context).push(new PageRouteBuilder(
//        opaque: false,
//        pageBuilder: (BuildContext context, _, __) {
//          return new HouseDetails(houseId, roomId, url: url,);
//        },
//        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
//          return new FadeTransition(
//            opacity: animation,
//            child: new FadeTransition(
//              opacity:
//                  new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
//              child: child,
//            ),
//          );
//        }));
//  }

  static route2Detail(BuildContext context, String houseId, String roomId,
      {String url}) {
    if (null == houseId) {
      return;
    }
    //手势滑动进入
    Navigator.of(context).push(new CupertinoPageRoute(builder: (c) {
      return new HouseDetails(
        houseId,
        roomId,
        url: url,
      );
    }));
  }
}
