import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_mvvm_frame/common/constants.dart';
import 'package:flutter_mvvm_frame/utils/encode_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'connectivity_request_retrier.dart';
import 'device_info.dart';
import 'http_result.dart';
import 'interceptors.dart';

class HttpManager {
  static HttpManager? _instance;

  factory HttpManager.getInstance() => _getInstance();

  static Dio? _dio;
  static LogsInterceptor _logsInterceptor = LogsInterceptor();
  static NoGzipLogInterceptor _noGzipLogInterceptor = NoGzipLogInterceptor();
  static NetCacheInterceptor _netCacheInterceptor = NetCacheInterceptor();

  static HttpManager _getInstance() {
    if (_instance == null) {
      _instance = HttpManager._internal();
    }
    return _instance!;
  }

  HttpManager._internal() {
    if (_dio == null) {
      _dio = Dio()
        ..options = BaseOptions(
          //baseUrl: Configurations.base_url,
          //queryParameters: {},
            connectTimeout: Configurations.connect_time_out,
            receiveTimeout: Configurations.receive_time_out,
            contentType: Headers.contentEncodingHeader,
            responseType: ResponseType.bytes)
        ..interceptors.addAll([_logsInterceptor, _netCacheInterceptor]);
    }
    _dio!.interceptors.add(RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: _dio!,
          connectivity: Connectivity(),
        )));
  }

  Future<HttpResult> rawGet(String url,
      {Map<String, dynamic>? queryParams, bool isGzip = true}) async {
    Map<String, dynamic> params = await DeviceInfoUtil.getPublicQueryParams();

    //公共参数需要加入接口参数
    if (queryParams != null) {
      params.addAll(queryParams);
    }

    _dio!.options.queryParameters = params;

    if (isGzip) {
      if (_dio!.interceptors.contains(_noGzipLogInterceptor)) {
        _dio!.interceptors.remove(_noGzipLogInterceptor);
        _dio!.interceptors.add(_logsInterceptor);
      }
    } else {
      if (_dio!.interceptors.contains(_logsInterceptor)) {
        _dio!.interceptors.remove(_logsInterceptor);
        _dio!.interceptors.add(_noGzipLogInterceptor);
      }
    }

    var response = await _dio!.get(url, queryParameters: queryParams);
    HttpResult res = isGzip
        ? HttpResult.fromJson(
        json.decode(utf8.decode(GZipCodec().decode(response.data))))
        : HttpResult.fromJson(json.decode(utf8.decode(response.data)));
    if (res.resultCode != '0') {
      Fluttertoast.showToast(msg: res.resultInfo ?? '请求错误');
    }
    return res;
  }

  Future<HttpResult> rawPost(String url, dynamic data,
      {Map<String, dynamic>? queryParameters, bool isGzip = true}) async {
    Map<String, dynamic> params = await DeviceInfoUtil.getPublicQueryParams();
    //公共参数需要加入接口参数
    if (queryParameters != null) {
      params.addAll(queryParameters);
    }

    if (isGzip) {
      if (_dio!.interceptors.contains(_noGzipLogInterceptor)) {
        _dio!.interceptors.remove(_noGzipLogInterceptor);
        _dio!.interceptors.add(_logsInterceptor);
      }
    } else {
      if (_dio!.interceptors.contains(_logsInterceptor)) {
        _dio!.interceptors.remove(_logsInterceptor);
        _dio!.interceptors.add(_noGzipLogInterceptor);
      }
    }

    var response =
    await _dio!.post(url, data: EncodeUtil.encodeRequestParams(params));
    var res = HttpResult.fromJson(
        json.decode(utf8.decode(GZipCodec().decode(response.data))));
    if (res.resultCode != '0') {
      Fluttertoast.showToast(msg: res.resultInfo ?? '请求错误');
    }
    return res;
  }
}

Stream<HttpResult> get(String url,
    {Map<String, dynamic>? params, bool isGzip = true}) =>
    Stream.fromFuture(HttpManager.getInstance()
        .rawGet(url, queryParams: params, isGzip: isGzip))
        .asBroadcastStream();

Stream<HttpResult> post(String url,
    {dynamic data, Map<String, dynamic>? queryParameters, bool isGzip = true}) {
  return Stream.fromFuture(HttpManager.getInstance()
      .rawPost(url, data, queryParameters: queryParameters, isGzip: isGzip))
      .asBroadcastStream();
}
