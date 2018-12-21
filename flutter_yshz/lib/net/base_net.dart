import 'dart:convert';

import 'package:dio/dio.dart';

class Api {
  Api._();

  //正式
  static const String baseUrl = "https://admin.yinsehuzhu.com";

  //测试
//  static const String baseUrl = "http://yanglao.house365.com";

  static const home = baseUrl + "/api/index/index";
}

class DioFactory {
  static Dio _dio;

  static DioFactory _instance;

  static DioFactory getInstance() {
    if (_instance == null) {
      _instance = new DioFactory._();
    }
    return _instance;
  }

  Options _baseOptions;

  DioFactory._() {
    //head 参数
    Map<String, String> head = new Map();
    head["cityid"] = "821";
    head["user_3rdsession"] = "nj";
    //基础请求参数设置
    _baseOptions = new Options(
        baseUrl: Api.baseUrl, headers: head, responseType: ResponseType.JSON);

    //请求类
    _dio = new Dio();
    _dio.options = _baseOptions;
    _dio.interceptor.response.onSuccess = (Response rsp) async {
      print("rsp->data=${rsp.data}");
      //不知道为啥自动解析不了了。。。
      if (rsp.data != null && rsp.data is String) {
        rsp.data = json.decode(rsp.data);
      }
      if (rsp.data != null && rsp.data["code"] == -999) {
        //登录失效
      }
      return rsp;
    };
    _dio.interceptor.request.onSend = (Options o) {
      if (o.data == null) {
        o.data = new Map();
      }
      if (o.data is Map) {
        o.data["cityid"] = "821";
        o.data["user_3rdsession"] = "";
      }
      print("req->${o.data}");
      return o;
    };
  }

  getDio() {
    return _dio;
  }
}
