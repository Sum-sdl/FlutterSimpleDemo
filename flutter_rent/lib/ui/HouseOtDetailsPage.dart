import 'package:flutter/material.dart';

class HouseDetails extends StatefulWidget {
  final String houseId;

  HouseDetails(this.houseId);

  @override
  State<StatefulWidget> createState() => _HouseDetailsState();
}

class _HouseDetailsState extends State<HouseDetails> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("房源详情"),
      ),
      body: Center(
        child: Text("房源id->${widget.houseId}"),
      ),
    );
  }
}
