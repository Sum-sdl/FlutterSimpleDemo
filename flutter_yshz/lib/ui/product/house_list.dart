import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_yshz/base.dart';
import 'package:flutter_yshz/bloc/bloc_provider.dart';
import 'package:flutter_yshz/bloc/sort_bloc.dart';
import 'package:flutter_yshz/common/widget/pub_title_widget.dart';

class HouseList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageCarState();
}

class _HomePageCarState extends State<HouseList> with BaseConfig, AutomaticKeepAliveClientMixin, AutoBlocMixin {

  SortBloc _carBloc;

  @override
  bool get wantKeepAlive => true;

  @override
  SortBloc get bloc => _carBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.stream,
        builder: (BuildContext c, AsyncSnapshot snap) {
          if (snap.hasData) {
            return buildChild(snap.data);
          } else if (snap.hasError) {
            return showErrorWidget();
          } else {
            return showLoadingWidget();
          }
        });
  }

  Future<void> _refreshLoadData() {
    return bloc.onRefreshTop();
  }

  Widget buildChild(SortBean data) {
    return Column(
      children: <Widget>[
        PubTitleWidget(
          titleText: "爱心陪居",
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refreshLoadData,
            child: new ListView.builder(
              itemBuilder: (c, index) {
                return Text("index $index");
              },
            ),
          ),
        ),
      ],
    );
  }
}
