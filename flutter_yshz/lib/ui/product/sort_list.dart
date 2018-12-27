import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_yshz/base.dart';
import 'package:flutter_yshz/bloc/bloc_provider.dart';
import 'package:flutter_yshz/bloc/sort_bloc.dart';
import 'package:flutter_yshz/common/widget/pub_title_widget.dart';
import 'package:flutter_yshz/resource.dart';
import 'package:flutter_yshz/ui/pub/pub_adv.dart';
import 'package:flutter_yshz/ui/router_helper.dart';

class SortList extends StatefulWidget {
  final String title;
  final String sortId;
  final bool hasChild;

  const SortList({Key key, this.title = "", this.sortId, this.hasChild = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SortListState();
}

class _SortListState extends State<SortList>
    with BaseConfig, AutomaticKeepAliveClientMixin, AutoBlocMixin {
  SortBloc _carBloc;

  @override
  bool get wantKeepAlive => true;

  @override
  SortBloc get bloc => _carBloc;

  ScrollController _scrollController;

  _scroll() {
    if (_scrollController.position.pixels + 300 >=
        _scrollController.position.maxScrollExtent) {
      bloc.onRefreshBottom();
    }
  }

  @override
  void initState() {
    _scrollController = new ScrollController();
    _scrollController.addListener(_scroll);
    _carBloc = new SortBloc(widget.sortId, hasChild: widget.hasChild);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          PubTitleWidget(
            titleText: widget.title,
          ),
          Expanded(
            child: StreamBuilder(
                stream: bloc.stream,
                builder: (BuildContext c, AsyncSnapshot snap) {
                  if (snap.hasData) {
                    return buildChild(snap.data);
                  } else if (snap.hasError) {
                    return showErrorWidget();
                  } else {
                    return showLoadingWidget();
                  }
                }),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshLoadData() {
    return bloc.onRefreshTop();
  }

  Widget buildChild(SortBean data) {
    //分类
    if (widget.hasChild) {
      return Column(
        children: <Widget>[
          BannerAdv(
            adv: data.adv,
            function: (Adv ad) {
              toastShow("hhh");
            },
          ),
          Expanded(
            child: GridView.count(
                crossAxisCount: 4,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1.1,
                padding: const EdgeInsets.only(top: 0.0),
                children: data.goods.map((Good t) {
                  return opItem(t.img, t.name, t.id.toString());
                }).toList()),
          ),
        ],
      );
    } else {
      //商品
      return RefreshIndicator(
        onRefresh: _refreshLoadData,
        child: new ListView.builder(
          padding: const EdgeInsets.only(top: 12.0),
          controller: _scrollController,
          itemCount: data.goods.length,
          itemBuilder: (c, index) {
            return itemGood(data.goods[index]);
          },
        ),
      );
    }
  }

  Widget opItem(String url, String name, String sortId) {
    return InkWell(
      onTap: () {
        RouterHelper.sort2List(context, name, sortId, false);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
              width: 34, height: 34, child: showNetImageWidgetGreyColor(url)),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              name,
              style: TextStyle(fontSize: 13.0),
            ),
          )
        ],
      ),
    );
  }

  Widget itemGood(Good good) {
    return GestureDetector(
      onTap: () {
        RouterHelper.sort2ListDetails(context, good.name, good.id.toString());
      },
      child: Container(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 92.0,
              height: 92.0,
              child: showNetImageWidgetGreyColor(good.imgList[0]),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      good.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 17.0,
                          height: 1.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, bottom: 4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            good.price,
                            style: TextStyle(
                                fontSize: 22.0,
                                color: ResColors.colorPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            good.unit,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: ResColors.colorPrimary,
                                fontWeight: FontWeight.w300),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "已售${good.soldnum}份",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: ResColors.color_text_888888,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      good.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: ResColors.color_text_888888,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
