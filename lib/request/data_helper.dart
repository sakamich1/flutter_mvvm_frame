import 'dart:collection';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
import 'package:ai_paint/common/constants.dart';
import 'package:ai_paint/utils/log_util.dart';


class DataHelper {

  static SplayTreeMap getPublicParams() {
    var map = SplayTreeMap<String, dynamic>();
    //map["token"] = sp.getString("token");
    //map["user_id"] = sp.getString("user_id");
    //map["channelroad"] = "";

    return map;
  }

  static encryptParams(Map<String, dynamic> map) {
    var buffer = StringBuffer();
    map.forEach((key,value) {
      buffer.write(key);
      buffer.write(value);
    });

    buffer.write("SERECT");
    LogUtil.v('bustring--->:' + buffer.toString());
    var sign = string2MD5(buffer.toString());
    map["sign"] = sign;
    LogUtil.v("sign--->" + sign);
    return map;
  }

  static string2MD5(String data) {
    var content = Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}