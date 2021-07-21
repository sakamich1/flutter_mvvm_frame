import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_mvvm_frame/common/constants.dart';

class EncodeUtil {
  EncodeUtil._();

  static String generateMd5(String data) {
    var content = Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  static String encodeRequestParams(Map<String, dynamic> originMap) =>
      base64.encode(
          _xor(utf8.encode(jsonEncode(originMap)), Strings.PROTO_ENCRYPT_KEY));

  static List<int> _xor(List<int> origin, String key) {
    int length = origin.length;
    int keyLength = key.length;
    int i = 0;
    int j = 0;
    while (i < length) {
      if (j >= keyLength) {
        j = 0;
      }
      origin[i] = origin[i] ^ (utf8.encode(key))[j];
      i++;
      j++;
    }
    return origin;
  }
}
