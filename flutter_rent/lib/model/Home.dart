class HotAdBean {
  final String hot_name;
  final String list_img;
  final int price;
  final int plate_id;
  final int area_id;
  final int ss_id;
  final int sl_id;

  HotAdBean({this.hot_name, this.list_img, this.plate_id, this.area_id,
    this.ss_id, this.sl_id, this.price});

  factory HotAdBean.fromJson(Map<String, dynamic> json) {
    return new HotAdBean(
        hot_name: json["hot_name"], list_img: json['list_img']);
  }

  //{"house_comefrom":1,"id":19026,"r_id":0,"all_rent":2000,"list_images":"https://aizuna.house365.com/upload_wx_images/2017/07/27/f6692aeafe6f73e47cb4ef34baa26a7c.jpg","house_title":"【整租】贝客白下高新店1室1厅"},{"house_comefrom":1,"id":19447,"r_id":0,"all_rent":4100,"list_images":"http://aizunaimg.house365.com/img10000/upload/2017/07/31/1501465837597e8ced72ad4.jpg","house_title":"【整租】南京图书发行大厦1室1厅"},
  factory HotAdBean.fromJson2(Map<String, dynamic> json) {
    return new HotAdBean(
        hot_name: json["house_title"], list_img: json['list_images'],price:json['all_rent']);
  }
}