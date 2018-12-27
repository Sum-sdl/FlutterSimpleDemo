import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_yshz/base.dart';
import 'package:flutter_yshz/bloc/bloc_provider.dart';
import 'package:flutter_yshz/bloc/sort_bloc.dart';
import 'package:flutter_yshz/common/widget/pub_title_widget.dart';

class SortList extends StatefulWidget {
  final String title;
  final String sortId;
  final bool hasChild;

  const SortList({Key key, this.title = "", this.sortId, this.hasChild = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageCarState();
}

class _HomePageCarState extends State<SortList>
    with BaseConfig, AutomaticKeepAliveClientMixin, AutoBlocMixin {
  SortBloc _carBloc;

  @override
  bool get wantKeepAlive => true;

  @override
  SortBloc get bloc => _carBloc;

  @override
  void initState() {
    _carBloc = new SortBloc(widget.hasChild, widget.sortId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
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
    );
  }

  Future<void> _refreshLoadData() {
    return bloc.onRefreshTop();
  }

  Widget buildChild(SortBean data) {
    return Column(
      children: <Widget>[
        PubTitleWidget(
          titleText: widget.title,
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
