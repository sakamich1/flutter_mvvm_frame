import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:ai_paint/common/constants.dart';

class EncodeUtil {
  static final Key _aesKey = Key.fromUtf8('zmtq20210512vpro');
  static final IV _aesIv = IV.fromUtf8('zmtq20210512vpro');
  static final Encrypter _encryptor =
  Encrypter(AES(_aesKey, mode: AESMode.cbc));
  
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

  static String generateAES(String content) =>
      _encryptor.encrypt(content, iv: _aesIv).base64;
}
