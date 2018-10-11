import 'package:flutter/material.dart';
import 'package:flutter_rent/Constants.dart';

class CommonDivider {

  //2者功能一样
  static Widget buildDividerLeftRight() {
    return new Padding(
      padding: const EdgeInsets.only(left: ResDimens.dimen_pub_padding,
          right: ResDimens.dimen_pub_padding),
      child: new Divider(height: 2.0),
    );
  }

  /// 思考const代码构造函数中的作用和意义
  /// const 定制常量组件，使得组件可以变成一个常量使用
  static const Widget buildDividerLeft = const Padding(
    padding: const EdgeInsets.only(left: ResDimens.dimen_pub_padding),
    child: const Divider(
      height: 2.0,
      color: Colors.red,
    ),
  );

  CommonDivider._();
}


class RouteUtils {

  static route2Detail(BuildContext context, String houseId) {
    if (null == houseId) {
      return;
    }
    Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
//          return new StoryDetailAppPage(id);
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(
            opacity: animation,
            child: new FadeTransition(
              opacity:
              new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: child,
            ),
          );
        }));
  }

}
