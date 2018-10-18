class HotAdBean {
  final String hotName;
  final String listImg;
  final String roomId;
  final String houseId;
  final int price;
  final int plateId;
  final int areaId;
  final int ssId;
  final int slId;
  final int houseComefrom;

  HotAdBean(
      {this.roomId, this.houseId, this.hotName, this.listImg, this.plateId, this.areaId,
        this.ssId, this.slId, this.price, this.houseComefrom});

  factory HotAdBean.fromJson(Map<String, dynamic> json) {
    return new HotAdBean(
        hotName: json["hot_name"], listImg: json['list_img']);
  }

  //{"house_comefrom":1,"id":19026,"r_id":0,"all_rent":2000,"list_images":"https://aizuna.house365.com/upload_wx_images/2017/07/27/f6692aeafe6f73e47cb4ef34baa26a7c.jpg","house_title":"【整租】贝客白下高新店1室1厅"},{"house_comefrom":1,"id":19447,"r_id":0,"all_rent":4100,"list_images":"http://aizunaimg.house365.com/img10000/upload/2017/07/31/1501465837597e8ced72ad4.jpg","house_title":"【整租】南京图书发行大厦1室1厅"},
  factory HotAdBean.fromJson2(Map<String, dynamic> json) {
    return new HotAdBean(
        hotName: json["house_title"],
        listImg: json['list_images'],
        roomId: json['r_id'].toString(),
        houseId: json['h_id'].toString(),
        houseComefrom: json['house_comefrom'],
        price: json['all_rent']);
  }
}