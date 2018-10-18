import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rent/Constants.dart';
import 'package:flutter_rent/base/BaseWidget.dart';
import 'package:flutter_rent/net/Api.dart';
import 'package:flutter_rent/widget/HomeBanner.dart';

class HouseDetails extends StatefulWidget {
  final String houseId;
  final String roomId;
  final String url;

  HouseDetails(this.houseId, this.roomId, {this.url = Api.details_gy});

  @override
  State<StatefulWidget> createState() => _HouseDetailsState();
}

class _HouseDetailsState extends State<HouseDetails> with BaseConfig {
  bool isFirstLoad = true;

  List<BannerInfo> topList = [];
  String houseDetails = "";

  Widget getBody() {
    if (isFirstLoad) {
      return loadingWidget();
    } else {
      return ListView(
        controller: _scroll,
        padding: const EdgeInsets.all(0.0),
        children: <Widget>[
          HomeBanner(topList, 240.0),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: <Widget>[
                Text(
                  _houseInfo["house_title"],
                  style: TextStyle(
                      color: ResColors.color_text_333333,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  houseDetails,
                  style: TextStyle(
                    color: ResColors.color_text_666666,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }
  }

  ScrollController _scroll;

  Map<String, dynamic> _houseInfo = new Map();

  _loadData() async {
    Map<String, String> p = new Map();
    p["city"] = "nj";
    p["h_id"] = widget.houseId;
    p["r_id"] = widget.roomId;
    dio.options.data = p; //请求参数

    try {
      Response response = await dio.get(widget.url);
      var data = response.data;
      if (data["code"] == 1) {
        _houseInfo = data["data"];
        topList.clear();

        String images = _houseInfo["detail_images"];
        if (isEmpty(images)) {
          images = _houseInfo["r_detail_images"];
        }
        images.split(",").forEach((url) {
          topList.add(BannerInfo(image: url));
        });

        //
        houseDetails = _houseInfo["details"];
        if (isEmpty(houseDetails)) {
          houseDetails = _houseInfo.toString();
        }
      } else {
        showSnackBarByKey(key, data["msg"]);
      }
    } catch (e) {
      print(e);
    }
    setState(() {});
    isFirstLoad = false;
  }

  @override
  void initState() {
    _scroll = new ScrollController();
    _loadData();
    super.initState();
  }

  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      body: Stack(
        children: <Widget>[
          getBody(),
          Title(_scroll),
        ],
      ),
    );
  }
}

//标题
class Title extends StatefulWidget {
  final ScrollController _scroll;

  Title(this._scroll);

  @override
  State<StatefulWidget> createState() => _TitleState();
}

class _TitleState extends State<Title> with BaseConfig {
  Color titleBg = Color(0x00FFFFFF);
  Color titleText = Colors.white;

  double percent = 0;

  _scrollListener() {
    double dis = widget._scroll.offset;
    double opacity = getProgressPercent(dis.round(), 120);
    percent = opacity;
    print(percent);
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
    widget._scroll.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    widget._scroll.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: titleBg,
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: percent != 1,
            child: Material(
              color: titleBg,
              elevation: percent == 1.0 ? 2.0 : 0.0,
              child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    height: 56.0,
                  )),
            ),
          ),
          SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 56.0,
                child: detailsTitle(),
              )),
        ],
      ),
    );
  }

  Widget detailsTitle() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new BackButton(
              color: titleText,
            ),
            Expanded(child: Text("")),
            new IconButton(
                onPressed: () {},
                icon: SizedBox(
                  child: Image.asset(
                    ResImages.image_nav_collect,
                    color: titleText,
                  ),
                  width: 22.0,
                  height: 22.0,
                )),
            new IconButton(
              onPressed: () {},
              iconSize: 22.0,
              icon: Icon(
                Icons.share,
                color: titleText,
              ),
            ),
          ],
        ),
        Text(
          "房源详情",
          style: TextStyle(inherit: false, color: titleText, fontSize: 18.0),
        ),
      ],
    );
  }
}
