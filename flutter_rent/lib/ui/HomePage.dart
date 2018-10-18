import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rent/Constants.dart';
import 'package:flutter_rent/model/Home.dart';
import 'package:flutter_rent/net/Api.dart';
import 'package:flutter_rent/net/DioFactory.dart';
import 'package:flutter_rent/utils/RouteHelper.dart';
import 'package:flutter_rent/utils/Utils.dart';
import 'package:flutter_rent/widget/Banner.dart';
import 'package:flutter_rent/widget/CommonWidget.dart';
import 'package:flutter_rent/widget/HouseInfoWidget.dart';
import 'package:flutter_rent/widget/common_snakeBar.dart';

class HomeView extends StatefulWidget {
  const HomeView();

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class OpItemData {
  final String name;
  final String localImage;

  const OpItemData(this.name, this.localImage);
}

class _HomePageState extends State<HomeView> {
  List<OpItemData> opItem;
  List<HouseInfoBean> houseWidget = [];
  List<HotAdBean> hotWidget = [];
  List<HotAdBean> recommendWidget = [];
  List<BannerInfo> houseBannerWidget = [];

  Future<Null> _loadData() async {
    Map<String, String> p = new Map();
    p["city"] = "nj";
    p["device_id"] = device_id;
    Dio dio = DioFactory.getInstance().getDio();
    dio.options.data = p; //请求参数
    Response response = await dio.get(Api.home);

    var data = response.data;
    if (data["code"] == 1) {
      //房源
      houseWidget.clear();
      var house = data["data"]["latestHouse"] as List<dynamic>;
      house.forEach((it) => houseWidget.add(HouseInfoBean.fromJson(it)));

      //广告
      houseBannerWidget.clear();
      (data["data"]["topAdvert"] as List<dynamic>)
          .forEach((it) => houseBannerWidget.add(BannerInfo.fromJson(it)));

      //热门区域
      hotWidget.clear();
      (data["data"]["hotArea"] as List<dynamic>)
          .forEach((it) => hotWidget.add(HotAdBean.fromJson(it)));

      //精选推荐
      recommendWidget.clear();
      (data["data"]["recommendHouse"] as List<dynamic>)
          .forEach((it) => recommendWidget.add(HotAdBean.fromJson2(it)));

      setState(() {});
    }
    var c = new Completer<Null>();
    c.complete(null);
    return c.future;
  }

  showLoadingDialog() {
    if (houseWidget.length == 0) {
      return true;
    }
    return false;
  }

  getProgressDialog() {
    return new Center(child: new CircularProgressIndicator());
  }

  @override
  void initState() {
    super.initState();
    opItem = new List();
    opItem.add(OpItemData("整租", ResImages.image_home_op1));
    opItem.add(OpItemData("合租", ResImages.image_home_op2));
    opItem.add(OpItemData("公寓", ResImages.image_home_op3));
    opItem.add(OpItemData("月付房源", ResImages.image_home_op4));
    opItem.add(OpItemData("地图找房", ResImages.image_home_op5));
    opItem.add(OpItemData("通勤找房", ResImages.image_home_op6));
    opItem.add(OpItemData("语言找房", ResImages.image_home_op7));
    opItem.add(OpItemData("支付房租", ResImages.image_home_op8));

    _scrollController = new ScrollController();
    _loadData();
  }

  ///把 ScrollController作为回调对象传给TitleWidget用来做局部刷新使用
  ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    print("HomeView build");
    return new RefreshIndicator(
      onRefresh: _loadData,
      child: getBody(),
    );
  }

  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return new Stack(
        children: <Widget>[
          content(),
          TitleWidget(_scrollController),
        ],
      );
    }
  }

  Widget content() {
    return ListView.builder(
      //设置为0，就没有默认间距了
        padding: EdgeInsets.only(top: 0.0),
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: houseWidget.length + 6,
        shrinkWrap: true,
        itemBuilder: (c, index) {
          Widget item;
          if (index == 0) {
            item = HomeBanner(houseBannerWidget, 194.0);
          } else if (index == 1) {
            item = new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
              opItem.sublist(0, 4).map((op) => barOpItem(op)).toList(),
            );
          } else if (index == 2) {
            item = new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
              opItem.sublist(4, 8).map((op) => barOpItem(op)).toList(),
            );
          } else if (index == 3) {
            item = contentJXTJ();
          } else if (index == 4) {
            item = contentRDQY();
          } else if (index == 5) {
            item = itemTitle("最新房源", true, () {
              CommonSnakeBar.buildSnakeBar(context, "最新房源");
            });
          } else {
            if (houseWidget.length > 0) {
              int info = index - 6;
              item = new HouseInfoWidget(houseWidget[info]);
            } else {
              item = new HouseInfoWidget(
                  HouseInfoBean(houseName: index.toString()));
            }
          }
          return item;
        });
  }

  Widget contentJXTJ() {
    return Column(
      children: <Widget>[
        itemTitle("精选推荐", true, () {
          CommonSnakeBar.buildSnakeBar(context, "精选推荐");
        }),
        SizedBox(
          width: double.infinity,
          height: 190.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            child: ListView.builder(
                itemCount: recommendWidget.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (c, index) =>
                    _jXTJItem(recommendWidget[index],
                        index == recommendWidget.length - 1)),
          ),
        ),
        CommonDivider.buildDivider
      ],
    );
  }

  Widget _jXTJItem(HotAdBean data, bool last) {
    return Padding(
      padding: last
          ? const EdgeInsets.only(right: 0.0)
          : const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          RouteHelper.route2Detail(context, data.houseId, data.roomId);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200.0,
              height: 122.0,
              child: getImage(data.listImg),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
              child: Text(data.hotName),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Text(
                '${data.price} 元/月',
                style: TextStyle(color: Theme
                    .of(context)
                    .accentColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget contentRDQY() {
    return Column(
      children: <Widget>[
        itemTitle("热点区域", false, () {}),
        SizedBox(
          width: double.infinity,
          height: 140.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            child: ListView.builder(
                itemCount: hotWidget.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (c, index) =>
                    _rDQYItem(hotWidget[index], index == hotWidget.length - 1)),
          ),
        ),
        CommonDivider.buildDivider
      ],
    );
  }

  Widget _rDQYItem(HotAdBean data, bool last) {
    return Padding(
      padding: last
          ? const EdgeInsets.only(right: 0.0)
          : const EdgeInsets.only(right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 100.0,
            width: 100.0,
            child: getImage(data.listImg),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
            child: Text(data.hotName),
          ),
        ],
      ),
    );
  }

  Widget getImage(String url) {
    if (url == null || url.length == 0) {
      return Image.asset(ResImages.image_error);
    }
    return CachedNetworkImage(
      imageUrl: url,
      fadeInDuration: const Duration(milliseconds: 300),
      placeholder: Image.asset(ResImages.image_error),
      errorWidget: Image.asset(ResImages.image_error),
      fit: BoxFit.fill,
    );
  }

  Widget itemTitle(String title, bool showRight, VoidCallback c) {
    Widget right;
    if (showRight) {
      right = Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              child: Text("查看更多"),
              onTap: c,
            )
          ],
        ),
      );
    } else {
      right = Expanded(child: Container());
    }
    return Padding(
      padding: const EdgeInsets.only(
          left: 14.0, top: 22.0, bottom: 8.0, right: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          right,
        ],
      ),
    );
  }

  Widget barOpItem(OpItemData item) {
    return new Expanded(
      child: new InkWell(
        onTap: () {
          _loadData();
        },
        child: Padding(
          padding: ResDimens.padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 34.0,
                height: 34.0,
                child: Image.asset(item.localImage),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: ResColors.color_text_666666,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

//标题栏
class TitleWidget extends StatefulWidget {
  final ScrollController _scrollController;

  TitleWidget(this._scrollController);

  @override
  State<StatefulWidget> createState() {
    return new TitleWidgetState();
  }
}

class TitleWidgetState extends State<TitleWidget> {
  Color titleBg = Color(0x00FFFFFF);
  Color titleText = Colors.white;

  double percent = 0;

  void _scroll() {
    double dis = widget._scrollController.offset;
    scrollListener(dis);
  }

  //滚动偏移量
  void scrollListener(double distance) {
    double opacity = Utils.progressPercent(distance.round(), 120);
    percent = opacity;
    int alpha = (255.0 * opacity).round();
    if (titleBg.alpha == alpha) {
      return;
    }
    titleText = Color.lerp(Colors.white, Colors.black, opacity);
    titleBg = titleBg.withOpacity(opacity);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget._scrollController.addListener(_scroll);
  }

  @override
  void dispose() {
    super.dispose();
    widget._scrollController.removeListener(_scroll);
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery
        .of(context)
        .padding;
    print('状态栏信息：$padding');
    return newTitle();
  }

//  //头部间距处理
//  Widget newTitle() {
//    return Material(
//      color: titleBg,
//      elevation: percent == 1.0 ? 2.0 : 0.0,
//      child: SafeArea(
//          child: searchTitle()),
//    );
//  }
  //头部间距处理
  Widget newTitle() {
    return Container(
      color: titleBg,
      child: Stack(
        children: <Widget>[
          Offstage(offstage: percent != 1, child: Material(
            color: titleBg,
            elevation: percent == 1.0 ? 2.0 : 0.0,
            child: SafeArea(
                child: SizedBox(width: double.infinity, height: 56.0,)),
          ),),
          SafeArea(child: searchTitle()),
        ],
      ),
    );
  }

  Widget searchTitle() {
    return SizedBox(
      width: double.infinity,
      height: 56.0,
      child: Padding(
        padding: EdgeInsets.only(
          left: 22.0,
          right: 22.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "南京",
              style: TextStyle(color: titleText, fontSize: 16.0),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 22.0),
                  child: GestureDetector(
                    onTap: () {
                      CommonSnakeBar.buildSnakeBar(context, "search click");
                    },
                    child: searchContainer(),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchContainer() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: const Color(0xd0f5f5f5)),
        padding:
        EdgeInsets.only(left: 12.0, right: 12.0, top: 6.6, bottom: 6.6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 17.0,
              height: 17.0,
              child: Image.asset(ResImages.image_home_search),
            ),
            Text(
              "  请输入小区、区域、地铁",
              style: TextStyle(color: Color(0xFFb5b5b5), fontSize: 13.0),
            ),
          ],
        ));
  }
}
