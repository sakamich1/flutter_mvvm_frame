import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fluttermvvmframe/utils/log_util.dart';


class LogsInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    LogUtil.v("请求baseUrl：${options.baseUrl}");
    LogUtil.v("请求url：${options.path}");
    LogUtil.v('请求头: ' + options.headers.toString());
    if (options.data != null) {
      LogUtil.v('请求参数: ' + options.data.toString());
    }
    return super.onRequest(options);
  }

  @override
  onResponse(Response response) {
    if (response != null) {
      var data = response.data;
      LogUtil.e('返回内容: ' + data.toString());
    }
    return super.onResponse(response); // continue
  }

  @override
  onError(DioError err) {
    LogUtil.e('请求异常: ' + err.toString());
    LogUtil.e('请求异常信息: ' + err.response?.toString() ?? "");
    return super.onError(err);
  }
}

class CommonInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) {
    return super.onRequest(options);
  }
}
