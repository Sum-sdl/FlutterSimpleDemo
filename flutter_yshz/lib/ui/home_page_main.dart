import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_yshz/base.dart';
import 'package:flutter_yshz/bloc/bloc_provider.dart';
import 'package:flutter_yshz/bloc/home_bloc.dart';

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

  Widget buildChild(HomeBean data) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 0.0),
      child: Column(
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
            color: Colors.green,
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
            color: Colors.brown,
            child: Row(
              children: <Widget>[
                buildSortItem("HelloWorld", ""),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      buildSortVerItem("2", ""),
                      buildSortVerItem("3", ""),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSortItem(String text, String url) {
    return Expanded(
        flex: 1,
        child: Container(
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(text),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: showNetImageWidget(url),
              ),
            ],
          ),
        ));
  }

  Widget buildSortVerItem(String text, String url) {
    return Expanded(
        flex: 1,
        child: Container(
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(text),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: showNetImageWidget(url),
              ),
            ],
          ),
        ));
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
          SizedBox(width: 40, height: 40, child: showNetImageWidget(url)),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              name,
              style: TextStyle(fontSize: 15.0),
            ),
          )
        ],
      ),
    );
  }
}
