import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_yshz/base.dart';
import 'package:flutter_yshz/bloc/bloc_provider.dart';
import 'package:flutter_yshz/bloc/home_bloc.dart';
import 'package:flutter_yshz/resource.dart';
import 'package:flutter_yshz/ui/router_helper.dart';

class HomePageMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain>
    with BaseConfig, AutomaticKeepAliveClientMixin, AutoBlocMixin {
  HomeBloc _homeBloc = new HomeBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  HomeBloc get bloc => _homeBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: StreamBuilder(
            stream: bloc.stream,
            builder: (BuildContext c, AsyncSnapshot<HomeBean> snap) {
              if (snap.hasData) {
                return buildChild(snap.data);
              } else if (snap.hasError) {
                return showErrorWidget();
              } else {
                return showLoadingWidget();
              }
            }),
        onRefresh: _refreshLoadData);
  }

  Future<void> _refreshLoadData() {
    return bloc.loadData();
  }

  Widget opItem(String url, String name, String sortId, int childNum) {
    return InkWell(
      onTap: () {
        RouterHelper.sort2List(context, name, sortId, childNum > 0);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 34, height: 34, child: showNetImageWidget(url)),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              name,
              style: TextStyle(fontSize: 13.0),
            ),
          )
        ],
      ),
    );
  }

  Widget buildChild(HomeBean data) {
    return new ListView(
      shrinkWrap: false,
      physics: AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 0.0),
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: 240.0,
          child: new Swiper(
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  toastShow("Index->$index");
                },
                child: showNetImageWidget(data.banner[index]["b_img"]),
              );
            },
            itemCount: data.banner.length,
            pagination: new SwiperPagination(
                builder: const DotSwiperPaginationBuilder(
                    size: 5.0, activeSize: 5.0)),
          ),
        ),
        Container(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 10.0),
          child: GridView.count(
              primary: true,
              shrinkWrap: true,
              crossAxisCount: 4,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1.1,
              padding: const EdgeInsets.only(top: 0.0),
              children: data.sorts.map((t) {
                return opItem(t["img"], t["name"], t["id"].toString(), t["hasChild"]);
              }).toList()),
        ),
        Container(
          color: Colors.white,
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 20.0),
          height: 211.0,
          child: Row(
            children: <Widget>[
              buildSortItem(_dataNews(data.news["1"])),
              Container(
                width: 1.0,
                color: ResColors.color_grey,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildSortVerItem(_dataNews(data.news["2"])),
                    Container(
                      height: 1.0,
                      color: ResColors.color_grey,
                    ),
                    buildSortVerItem(_dataNews(data.news["3"])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<String> _dataNews(dynamic itemNews) {
    if (itemNews == null) {
      return const ["", "", "", ""];
    }
    return [
      itemNews["title"],
      itemNews["title_two"],
      itemNews["b_img"],
      itemNews["title_three"]
    ];
  }

  Widget buildSortItem(List<String> data) {
    var title = data[0];
    var tip = data[1];
    var url = data[2];
    return Container(
      padding: const EdgeInsets.all(14.0),
      width: 160.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Text(
              title,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            tip,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
            TextStyle(fontSize: 12.0, color: ResColors.color_text_888888),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(height: 120.0, child: showNetEmptyImageWidget(url)),
          ),
        ],
      ),
    );
  }

  Widget buildSortVerItem(List<String> data) {
    var title = data[0];
    var tip = data[1];
    var url = data[2];
    var tip2 = data[3];
    return Container(
      height: 105.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, top: 10.0, bottom: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    tip,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 13.0,
                        color: ResColors.color_text_888888),
                  ),
                ),
                Text(
                  tip2 * 10,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 13.0,
                      color: ResColors.color_text_888888),
                ),
              ],
            ),
              )),
          Padding(
            padding:
            const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 12.0),
            child: showNetEmptyImageWidget(url),
          ),
        ],
      ),
    );
  }
}
