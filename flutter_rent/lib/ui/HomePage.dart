import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rent/Constants.dart';
import 'package:flutter_rent/net/Api.dart';
import 'package:flutter_rent/net/DioFactory.dart';
import 'package:flutter_rent/utils/Utils.dart';
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

  _loadData(String tag) async {
    Map<String, String> p = new Map();
    p["city"] = "nj";
    p["device_id"] = "ffffffff-8650-ca15-ffff-ffffd8967aa8";
    Dio dio = await DioFactory.getInstance().getDio();
    dio.options.data = p; //请求参数
    Response response = await dio.get(Api.home);
    print(response.toString());
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
    _loadData("HomeView initState");
  }

  ///把 ScrollController作为回调对象传给TitleWidget用来做局部刷新使用
  ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    print("HomeView build");
    return new Stack(
      children: <Widget>[
        content(),
        TitleWidget(_scrollController),
      ],
    );
  }

  Widget content() {
    return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        itemBuilder: (c, index) {
          Widget item;
          if (index == 0) {
            item = contentBanner();
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
          } else {
            item = new HouseInfoWidget(HouseInfoBean(houseName: "$index"));
          }
          return item;
        });
  }

  Widget contentBanner() {
    return new Container(
      height: 180.0,
      color: Colors.orangeAccent,
    );
  }

  Widget barOpItem(OpItemData item) {
    return new Expanded(
      child: new InkWell(
        onTap: () {
          _loadData(item.name);
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
                  padding: const EdgeInsets.only(top: 5.0),
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
    //滚动一点就会触发
    return new Stack(
      children: <Widget>[
        title(),
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

  Widget title() {
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
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container searchContainer() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: const Color(0xd8f5f5f5)),
        padding: EdgeInsets.only(
            left: 12.0, right: 12.0, top: 9.0, bottom: 9.0),
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
              style: TextStyle(
                  color: Color(0xFFb5b5b5), fontSize: 14.0),
            ),
          ],
        ));
  }
}
