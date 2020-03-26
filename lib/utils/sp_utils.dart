import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  static SPUtil _instance;
  static SharedPreferences _sp;

  SPUtil._internal();

  static Future<SPUtil> get instance async {
    return await getInstance();
  }

  Future _init() async {
    _sp = await SharedPreferences.getInstance();
  }

  static Future<SPUtil> getInstance() async {
    if (_instance == null) {
      _instance = SPUtil._internal();
      await _instance._init();
    }
    return _instance;
  }

  Set<String> getKeys() => _sp?.getKeys();

  get(String key) => _sp?.get(key);

  String getString(String key) => _sp?.getString(key);

  Future<bool> putString(String key,String value) => _sp?.setString(key,value);

  bool getBool(String key) => _sp?.getBool(key);

  Future<bool> putBool(String key,bool value) => _sp?.setBool(key,value);

  int getInt(String key) => _sp?.getInt(key);

  Future<bool> putInt(String key,int value) => _sp?.setInt(key,value);

  double getDouble(String key) => _sp?.getDouble(key);

  Future<bool> putDouble(String key,double value) => _sp?.setDouble(key,value);

  List<String> getStringList(String key) => _sp?.getStringList(key);

  Future<bool> putStringList(String key,List<String> value) =>
    _sp?.setStringList(key,value);

  dynamic getDynamic(String key) => _sp?.get(key);


  Future<bool> remove(String key) => _sp?.remove(key);

  Future<bool> clear() => _sp?.clear();
}