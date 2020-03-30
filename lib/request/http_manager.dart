import 'package:dio/dio.dart';
import 'package:easy_toast/easy_toast.dart';
import 'package:flutter_mvvm_frame/common/constants.dart';
import 'package:rxdart/rxdart.dart';

import 'http_result.dart';
import 'interceptors.dart';

class HttpManager {
  static HttpManager _instance;

  static HttpManager get instance => _getInstance();

  Dio dio;
  BaseOptions options;

  factory HttpManager()=> _getInstance();

  HttpManager._internal(){
    dio = Dio()
      ..options = BaseOptions(
        baseUrl: Configurations.base_url,
        queryParameters: {
          "token": "",
          "user_id": ""
        },
        connectTimeout: Configurations.connect_time_out,
        receiveTimeout: Configurations.receive_time_out)
      ..interceptors.addAll(
        [CommonInterceptor(),
          LogsInterceptors()]
      );
  }

  static HttpManager _getInstance() {
    if (_instance == null) {
      _instance = HttpManager._internal();
    }
    return _instance;
  }

  /*.asBroadcastStream();*/

  Future<HttpResult> _rawGet(String url,{Map<String, dynamic> params}) async {
    var response = await HttpManager.instance.dio.get(
      url,
      queryParameters: params);
    HttpResult res = HttpResult.fromJson(response.data);
    if (res.code != 1) {
      toast(res.msg);
    }
    return res;
  }


//.asBroadcastStream();

  Future<HttpResult> _rawPost(String url,
                              dynamic data,
                              { Map<String, dynamic> queryParameters}) async {
    var response = await HttpManager.instance.dio.post(
      url,data: data,queryParameters: queryParameters);
    var res = HttpResult.fromJson(response.data);
    if (res.code != 1) {
      toast(res.msg);
    }
    return res;
  }
}

Stream<HttpResult> get(String url,{Map<String, dynamic> params}) =>
  Stream.fromFuture(HttpManager.instance._rawGet(url,params: params));

Stream<HttpResult> post(String url,{dynamic data,Map<String,
  dynamic> queryParameters}) =>
  Stream.fromFuture(HttpManager.instance._rawPost(url,data,queryParameters: queryParameters));

