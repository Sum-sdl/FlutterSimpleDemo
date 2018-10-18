import 'package:flutter/material.dart';

class HouseDetails extends StatefulWidget {
  final String houseId;
  final String roomId;

  HouseDetails(this.houseId, this.roomId);

  @override
  State<StatefulWidget> createState() => _HouseDetailsState();
}

class _HouseDetailsState extends State<HouseDetails> {

  bool isFirstLoad = true;

  Widget getBody() {
    if (isFirstLoad) {
      return Center(child: CircularProgressIndicator(),);
    } else {
      return ListView.separated(
          itemBuilder: null, separatorBuilder: null, itemCount: null);
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("房源详情"),
      ),
      body: Center(
        child: Text("房源id->${widget.houseId},${widget.roomId}"),
      ),
    );
  }
}
