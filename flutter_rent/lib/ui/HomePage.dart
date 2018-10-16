import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rent/Constants.dart';
import 'package:flutter_rent/model/Home.dart';
import 'package:flutter_rent/net/Api.dart';
import 'package:flutter_rent/net/DioFactory.dart';
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

//**
// * topAdvert : [{"advert_id":114,"advert_status":1,"advert_name":"","advert_sort":0,"advert_url":"","advert_image":"http://img12.house365.com/upload/2017/09/06/150469080859afc2787c44c.png","advert_editTime":1504690935,"advert_type":8,"advert_detail":"app顶部广告","advert_start":1504690773,"advert_end":1507369174,"advert_client":2,"city":"nj"}]
// * midAdvert : [{"advert_id":115,"advert_status":1,"advert_name":"","advert_sort":1,"advert_url":"","advert_image":"http://img13.house365.com/upload/2017/09/06/150469089759afc2d162474.png","advert_editTime":1504690924,"advert_type":9,"advert_detail":"app首页测试广告","advert_start":1504690896,"advert_end":1507282898,"advert_client":2,"city":"nj"}]
// * informations : ["测试标题333"]
// * hotArea : [{"plate_id":0,"area_id":0,"ss_id":2,"sl_id":1,"hot_name":"测试","list_img":"http://aizunaimg.house365.com/img10000/upload/2017/05/16/1494913618591a9252e06d7.png"},{"plate_id":540,"area_id":777,"ss_id":0,"sl_id":0,"hot_name":"区属","list_img":"https://ss0.baidu.com/73x1bjeh1BF3odCf/it/u=138126325,1485620701&fm=85&s=7FAB2EC3909A35D01E299C1A030010D2"}]
// * recommendHouse : [{"house_comefrom":1,"id":19026,"r_id":0,"all_rent":2000,"list_images":"https://aizuna.house365.com/upload_wx_images/2017/07/27/f6692aeafe6f73e47cb4ef34baa26a7c.jpg","house_title":"【整租】贝客白下高新店1室1厅"},{"house_comefrom":1,"id":19447,"r_id":0,"all_rent":4100,"list_images":"http://aizunaimg.house365.com/img10000/upload/2017/07/31/1501465837597e8ced72ad4.jpg","house_title":"【整租】南京图书发行大厦1室1厅"},{"house_comefrom":1,"id":27021,"r_id":0,"all_rent":1870,"list_images":"http://aizunaimg.house365.com/img10000/upload/2017/08/18/1503041012599695f4389f9.jpg","house_title":"【整租】龙湖冠寓九竹店1室1厅"},{"house_comefrom":1,"id":28074,"r_id":27859,"all_rent":1360,"list_images":"http://aizunaimg.house365.com/img10000/upload/2017/08/19/150308348859973be054eee.jpg","house_title":"【合租】虎踞北路75号3室1厅主卧"},{"house_comefrom":1,"id":28091,"r_id":27873,"all_rent":1460,"list_images":"http://aizunaimg.house365.com/img10000/upload/2017/08/19/150308615359974649b825f.jpg","house_title":"【合租】万达东坊3室1厅主次"},{"house_comefrom":1,"id":33244,"r_id":32050,"all_rent":1300,"list_images":"http://aizunaimg.house365.com/img10000/upload/2017/08/24/1503558362599e7ada0b663.jpg","house_title":"【合租】拉德芳斯3室1厅主卧"}]
// * latestHouse : [{"h_id":25089,"r_id":0,"l_id":0,"house_type":1,"address":"中山东路56","c_id":541,"s_id":"","xiaoqu_id":6141,"xiaoqu_name":"南京图书发行大厦","lease_mode":1,"room":1,"hall":1,"kitchen":0,"toilet":1,"acreage":30,"r_acreage":0,"rent":4050,"r_rent":0,"rent_intro":"元/月","renovation_id":3,"orientation_id":4,"r_orientation_id":4,"special":"1,2,3,4,5,7","r_special":"","detail":"","r_description":"","list_images":"http://aizunaimg.house365.com/img10000/upload/2017/08/17/150296049659955b702ec31.jpg","r_list_images":"","detail_images":"http://aizunaimg.house365.com/img10000/upload/2017/08/17/150296050359955b77b36d1.jpg,http://aizunaimg.house365.com/img10000/upload/2017/08/17/150296050659955b7aa82a6.jpg,http://aizunaimg.house365.com/img10000/upload/2017/08/17/150296050959955b7dc533b.jpg,http://aizunaimg.house365.com/img10000/upload/2017/08/17/150296051259955b80b05aa.jpg,http://aizunaimg.house365.com/img10000/upload/2017/08/17/150296051659955b84086d8.jpg,http://aizunaimg.house365.com/img10000/upload/2017/08/17/150296051859955b86df8d8.jpg","r_detail_images":"","facilities":"2,3,4,5,1,8,15,10,11,12,14,9,7,16","r_facilities":"2,3,4,5,1,8,15,10,11,12,14,9,7,16","add_time":1502960555,"h_detail_info":"南京图书发行大厦9栋2单元12室","city":"nj","rooms_num":0,"pay_monthly":1,"c_business":"","c_business_key":"","h_pay_type":1,"r_name":"","house_title":"【整租】南京图书发行大厦1室1厅","hasYh":1,"distance_subway":"","house_comefrom":1,"panorama":[],"xiaoqu_address":"","xiaoqu_info":{"lng":118.794234,"lat":32.047266,"xiaoqu_address":"中山东路56","xiaoqu_name":"南京图书发行大厦","xiaoqu_id":6141,"xdistrict":541,"xdistrict_name":"秦淮区","xstreet":603,"xstreet_name":"新街口"},"work_transit":"","work_minutes":""}]
// * hasNewMessage :
// */

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
    print(response.data);
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
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        itemCount: houseWidget.length + 6,
        itemBuilder: (c, index) {
          Widget item;
          if (index == 0) {
            item = HomeBanner(houseBannerWidget, 190.0);
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
                itemBuilder: (c, index) => _JXTJItem(recommendWidget[index])),
          ),
        ),
        CommonDivider.buildDivider
      ],
    );
  }

  Widget _JXTJItem(HotAdBean data) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 200.0,
            height: 122.0,
            child: getImage(data.list_img),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
            child: Text(data.hot_name),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Text(
              '${data.price} 元/月',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ),
        ],
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
                itemBuilder: (c, index) => _RDQYItem(hotWidget[index])),
          ),
        ),
        CommonDivider.buildDivider
      ],
    );
  }

  Widget _RDQYItem(HotAdBean data) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 100.0,
            width: 100.0,
            child: getImage(data.list_img),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
            child: Text(data.hot_name),
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
                width: 38.0,
                height: 38.0,
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
    double opacity = Utils.progressPercent(distance.round(), 125);
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
    //滚动一点就会触发
    return new Stack(
      children: <Widget>[
        searchTitle(),
        Offstage(
          offstage: percent != 1,
          child: Container(
            height: 80.0,
            decoration: BoxDecoration(
                border:
                Border(bottom: BorderSide(color: ResColors.color_line))),
          ),
        )
      ],
    );
  }

  Widget searchTitle() {
    return Container(
      height: 80.0,
      color: titleBg,
      child: Padding(
        padding: EdgeInsets.only(
            left: 22.0,
            right: 22.0,
            top: ResDimens.dimen_pub_status_bar_height),
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
            color: const Color(0xd8f5f5f5)),
        padding:
        EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
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
              style: TextStyle(color: Color(0xFFb5b5b5), fontSize: 14.0),
            ),
          ],
        ));
  }
}
