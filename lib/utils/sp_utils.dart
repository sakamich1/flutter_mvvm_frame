import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  static SPUtil? _instance;
  static SharedPreferences? _sp;

  SPUtil._internal();

  static Future<void> _init() async {
    if (_sp == null) {
      _sp = await SharedPreferences.getInstance();
    }
  }

  static Future<SPUtil> getInstance() async{
    if (_instance == null) {
      await _init();
      _instance = SPUtil._internal();
    }
    return _instance!;
  }

  Set<String>? getKeys() => _sp?.getKeys();

  get(String key) => _sp?.get(key);

  String getString(String key, {String defaultValue = ""}) =>
      _sp?.getString(key) ?? defaultValue;

  Future<bool>? putString(String key, String value) =>
      _sp?.setString(key, value);

  bool getBool(String key, {bool defaultValue = false}) =>
      _sp?.getBool(key) ?? defaultValue;

  Future<bool>? putBool(String key, bool value) => _sp?.setBool(key, value);

  int getInt(String key, {int defaultValue = -1}) =>
      _sp?.getInt(key) ?? defaultValue;

  Future<bool>? putInt(String key, int value) => _sp?.setInt(key, value);

  double getDouble(String key, {double defaultValue = -1}) =>
      _sp?.getDouble(key) ?? defaultValue;

  Future<bool>? putDouble(String key, double value) =>
      _sp?.setDouble(key, value);

  List<String>? getStringList(String key) => _sp?.getStringList(key);

  Future<bool>? putStringList(String key, List<String> value) =>
      _sp?.setStringList(key, value);

  Future<bool>? putJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return _sp?.setString(key, jsonString);
  }

  dynamic getJSON(String key) {
    String? jsonString = _sp?.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  Object? getDynamic(String key) => _sp?.get(key);

  Future<bool>? remove(String key) => _sp?.remove(key);

  Future<bool>? clear() => _sp?.clear();
}
