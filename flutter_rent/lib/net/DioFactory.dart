import 'package:dio/dio.dart';
import 'package:flutter_rent/net/Api.dart';

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
    _dio = new Dio();

    ///head 参数
    Map<String, String> head = new Map();
    head["debug"] = "0";
    head["version"] = "v1.0";
    head["city"] = "nj";
    head["access-token"] = "ed6ae5170b8b52add9327dd090699e84";
    head["user-token"] = "a08b47e1e764063e3807a49e83c4124d";
    //基础请求参数设置
    _baseOptions = new Options(baseUrl: Api.base, headers: head);
    _dio.options = _baseOptions;
  }

  getDio() {
    return _dio;
  }
}
