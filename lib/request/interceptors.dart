import 'dart:convert';
import 'dart:io';
import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:ai_paint/utils/log_util.dart';
import 'package:ai_paint/utils/sp_utils.dart';
import 'package:get/get.dart' as getX;
import 'cache.dart';
import 'connectivity_request_retrier.dart';
import 'exception.dart';

///日志拦截器，也管理错误信息
class LogsInterceptor extends InterceptorsWrapper {
  final tag = 'LogsInterceptor';

  @override
  onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    LogUtil.v("请求url：${options.path}");
    LogUtil.v('请求头: ${options.headers}', tag: tag);
    LogUtil.v('请求方法: ${options.method}');
    if (options.method == "GET") {
      LogUtil.v('请求参数: ${options.queryParameters}', tag: tag);
    } else if (options.method == "POST") {
      if (options.data != null) {
        LogUtil.v('请求参数: ${options.data}', tag: tag);
      }
    }

    return super.onRequest(options, handler);
  }

  @override
  onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) {
    var data = response.data;
    LogUtil.e('返回码: ${response.statusCode}', tag: tag);
    LogUtil.e('返回内容: ${utf8.decode(GZipCodec().decode(data))}', tag: tag);
    super.onResponse(response, handler); // continue
  }

  @override
  onError(
      DioError err,
      ErrorInterceptorHandler handler,
      ) {
    // error统一处理
    AppException appException = AppException.create(err);
    //err.error = appException;

    LogUtil.e('请求异常: ' + err.toString(), tag: tag);
    LogUtil.e('请求异常信息: ' + (err.response?.toString() ?? ""), tag: tag);
    return super.onError(err, handler);
  }
}

class NoGzipLogInterceptor extends Interceptor {
  final tag = 'NoGzipLogsInterceptor';

  @override
  onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    LogUtil.v("请求url：${options.path}");
    LogUtil.v('请求头: ${options.headers}', tag: tag);
    LogUtil.v('请求方法: ${options.method}');

    if (options.method == "GET") {
      LogUtil.v('请求参数: ${options.queryParameters}', tag: tag);
    } else if (options.method == "POST") {
      if (options.data != null) {
        LogUtil.v('请求参数: ${options.data}', tag: tag);
      }
    }
    return super.onRequest(options, handler);
  }

  @override
  onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) {
    var data = response.data;
    LogUtil.e('返回码: ${response.statusCode}', tag: tag);
    LogUtil.e('返回内容: ${utf8.decode(data)}', tag: tag);
    super.onResponse(response, handler); // continue
  }

  @override
  onError(
      DioError err,
      ErrorInterceptorHandler handler,
      ) {
    // error统一处理
    AppException appException = AppException.create(err);
    //err.error = appException;

    LogUtil.e('请求异常: ' + err.toString(), tag: tag);
    LogUtil.e('请求异常信息: ' + (err.response?.toString() ?? ""), tag: tag);
    return super.onError(err, handler);
  }
}

///缓存拦截器
class NetCacheInterceptor extends Interceptor {
  // 为确保迭代器顺序和对象插入时间一致顺序一致，我们使用LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();
  var sp = getX.Get.find<SPUtil>();

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);
    if (!CACHE_ENABLE) return handler.next(options);

    // refresh标记是否是刷新缓存
    bool refresh = options.extra["refresh"] == true;

    // 是否磁盘缓存
    bool cacheDisk = options.extra["cacheDisk"] == true;

    // 如果刷新，先删除相关缓存
    if (refresh) {
      // 删除uri相同的内存缓存
      delete(options.uri.toString());

      // 删除磁盘缓存
      if (cacheDisk) {
        await sp.remove(options.uri.toString());
      }

      return handler.next(options);
    }

    // get 请求，开启缓存
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra["cacheKey"] ?? options.uri.toString();

      // 策略 1 内存缓存优先，2 然后才是磁盘缓存

      // 1 内存缓存
      var ob = cache[key];
      if (ob != null) {
        //若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            CACHE_MAX_AGE) {
          handler.resolve(cache[key]!.response);
        } else {
          //若已过期则删除缓存，继续向服务器请求
          cache.remove(key);
        }
      }

      // 2 磁盘缓存
      if (cacheDisk) {
        var cacheData = sp.getJSON(key);
        if (cacheData != null) {
          handler.resolve(
            Response(
              statusCode: 200,
              data: cacheData,
              requestOptions: options,
            ),
          );
        }
      }
    }
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
    // 错误状态不缓存
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    super.onResponse(response, handler);
    // 如果启用缓存，将返回结果保存到缓存
    if (CACHE_ENABLE) {
      await _saveCache(response);
    }
  }

  Future<void> _saveCache(Response object) async {
    RequestOptions options = object.requestOptions;

    // 只缓存 get 的请求
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      // 策略：内存、磁盘都写缓存

      // 缓存key
      String key = options.extra["cacheKey"] ?? options.uri.toString();

      // 磁盘缓存
      if (options.extra["cacheDisk"] == true) {
        await sp.putJSON(key, object.data);
      }

      // 内存缓存
      // 如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if (cache.length == CACHE_MAX_COUNT) {
        cache.remove(cache[cache.keys.first]);
      }

      cache[key] = CacheObject(object);
    }
  }

  void delete(String key) {
    cache.remove(key);
  }
}

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (_shouldRetry(err)) {
      try {
        requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        throw e;
      }
    }
    super.onError(err, handler);
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.unknown &&
        err.error != null &&
        err.error is SocketException;
  }
}
