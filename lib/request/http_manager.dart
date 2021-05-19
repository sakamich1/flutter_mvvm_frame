import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_mvvm_frame/common/constants.dart';
import 'connectivity_request_retrier.dart';
import 'http_result.dart';
import 'interceptors.dart';

class HttpManager {
  static HttpManager? _instance;
  factory HttpManager.getInstance() => _getInstance();

  late Dio? dio;
  BaseOptions? options;

  static HttpManager _getInstance() {
    if (_instance == null) {
      _instance = HttpManager._internal();
    }
    return _instance!;
  }

  HttpManager._internal() {
    if (dio == null) {
      dio = Dio()
        ..options = BaseOptions(
            baseUrl: Configurations.base_url,
            queryParameters: {"token": "", "user_id": ""},
            connectTimeout: Configurations.connect_time_out,
            receiveTimeout: Configurations.receive_time_out)
        ..interceptors.addAll([NetCacheInterceptor(), LogsInterceptors(),RetryOnConnectionChangeInterceptor(requestRetrier: DioConnectivityRequestRetrier(
          dio: dio!,
          connectivity: Connectivity(),
        ))]);
    }
  }

  Future<HttpResult> rawGet(String url, {Map<String, dynamic>? params}) async {
    var response = await dio!.get(url, queryParameters: params);
    HttpResult res = HttpResult.fromJson(response.data);
    if (res.code != 1) {
      //toast(res.msg);
    }
    return res;
  }

  Future<HttpResult> rawPost(String url, dynamic data,
      {Map<String, dynamic>? queryParameters}) async {
    var response =
        await dio!.post(url, data: data, queryParameters: queryParameters);
    var res = HttpResult.fromJson(response.data);
    if (res.code != 1) {
      //toast(res.msg);
    }
    return res;
  }
}

Stream<HttpResult> get(String url, {Map<String, dynamic>? params}) =>
    Stream.fromFuture(HttpManager.getInstance().rawGet(url, params: params));

Stream<HttpResult> post(String url,
        {dynamic data, Map<String, dynamic>? queryParameters}) =>
    Stream.fromFuture(HttpManager.getInstance().rawPost(url, data, queryParameters: queryParameters));
