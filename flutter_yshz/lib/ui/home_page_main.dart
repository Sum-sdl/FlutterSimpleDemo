import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_yshz/base.dart';
import 'package:flutter_yshz/bloc/bloc_provider.dart';
import 'package:flutter_yshz/bloc/home_bloc.dart';
import 'package:flutter_yshz/resource.dart';

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

  Widget opItem(String url, String name) {
    return InkWell(
      onTap: () {
        toastShow(name);
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
          child: GridView.count(
              primary: true,
              shrinkWrap: true,
              crossAxisCount: 4,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1.1,
              padding: const EdgeInsets.only(top: 0.0),
              children: data.sorts.map((t) {
                return opItem(t["img"], t["name"]);
              }).toList()),
        ),
        Container(
          height: 10.0,
          color:  ResColors.colorBg,
        ),
        SizedBox(
          width: double.infinity,
          height: 211.0,
          child: Row(
            children: <Widget>[
              buildSortItem(_dataNews(data.news["1"])),
              Container(
                width: 1.0,
                color: ResColors.color_grey,
              ),
              Expanded(
                flex: 1,
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
      itemNews["title_two"]
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
            padding: const EdgeInsets.only(top: 4.0, bottom: 2.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
          Text(
            tip,
            style: TextStyle(fontSize: 14.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
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
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(title),
                Text(tip),
                Text(tip2),
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: showNetEmptyImageWidget(url),
          ),
        ],
      ),
    );
  }
}
