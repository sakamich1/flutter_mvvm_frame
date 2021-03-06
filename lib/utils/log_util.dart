import 'dart:developer';

class LogUtil {
  static bool isRelease = const bool.fromEnvironment("dart.vm.product");
  static String tag = "LOG_UTIL";

  static void e(Object object, {String? tag}) {
    if (!isRelease) {
      _printLog(tag??LogUtil.tag, '/Error : ', object);
    }
  }

  static void v(Object object, {String? tag}) {
    if (!isRelease) {
      _printLog(tag??LogUtil.tag, '/Verbose : ', object);
    }
  }

  static void _printLog(String? tag, String stag, Object object) {
    StringBuffer sb = new StringBuffer()
      ..write(tag)
      ..write(stag)
      ..write(object);
    log(sb.toString());
  }
}
