import 'dart:io';

import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

class PackageUtil {
  PackageUtil._();

  static Future<String> getChannelName() async {
    var packageInfo = await PackageInfo.fromPlatform();

    String channelName = '';
    switch (packageInfo.packageName) {
      case 'com.zuimeiweather.elderly':
        channelName = 'hw';
        break;

      case 'com.zuimeiweatherxm.elderly':
        channelName = 'xm';
        break;

      case 'com.zuimeiweatheroppo.elderly':
        channelName = 'oppo';
        break;

      case 'com.zuimeiweathervivo.elderly':
        channelName = 'vivo';
        break;

      case 'com.zuimeiweatherdroi.elderly':
        channelName = 'droi';
        break;
    }
    return channelName;
  }

  static Future<String> getChannelNameNative() async {
    const platform = const MethodChannel('com.zuimeiweather.elderly');
    String channelName = '';
    if (Platform.isAndroid) {
      try {
        channelName = await platform.invokeMethod('getChannelName');
      } on PlatformException catch (e) {
        print(e.toString());
      }
    } else if (Platform.isIOS) {
      channelName = 'apple';
    }

    return channelName;
  }

  static Future<void> initUMSdk() async {
    const platform = const MethodChannel('com.zuimeiweather.elderly');
    try {
      await platform.invokeMethod('initUMSdk');
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }
}
