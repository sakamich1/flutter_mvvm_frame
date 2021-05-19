// 是否启用缓存
import 'package:dio/dio.dart';

const CACHE_ENABLE = true;

// 缓存的最长时间，单位（秒）
const CACHE_MAX_AGE = 1000;

// 最大缓存数
const CACHE_MAX_COUNT = 100;

class CacheObject {
  CacheObject(this.response)
    : timeStamp = DateTime.now().millisecondsSinceEpoch;
  Response response;
  int timeStamp;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

