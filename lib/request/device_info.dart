import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_mvvm_frame/common/constants.dart';
import 'package:flutter_mvvm_frame/module/main/entity/location_entity.dart';
import 'package:flutter_mvvm_frame/utils/encode_util.dart';
import 'package:flutter_mvvm_frame/utils/sp_utils.dart';
import 'package:flutter_mvvm_frame/utils/ui_utils.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class DeviceInfoUtil {
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  DeviceInfoUtil._internal();

  static Future<AndroidDeviceInfo> getAndroidInfo() async =>
      await deviceInfo.androidInfo;

  static Future<IosDeviceInfo> getIOSDeviceInfo() async =>
      await deviceInfo.iosInfo;

  static Future<Map<String, dynamic>> getPublicQueryParams() async {
    Map<String, dynamic> queryMap = Map();

    var packageInfo = await PackageInfo.fromPlatform();
    Map<String, dynamic>? locationJson =
        Get.find<SPUtil>().getJSON(SPKeys.KEY_LOCATION_DATA);

    if (locationJson != null) {
      LocationEntity locationInfo = LocationEntity.fromJson(locationJson);
      /*queryMap
        ..[Keys.COMMON_CITY_LATITUDE] = '${locationInfo.latitude}'
        ..[Keys.COMMON_CITY_LONGITUDE] = '${locationInfo.longitude}';*/
    }

    queryMap
      ..[Keys.COMMON_USER_ID] = ''
      //..[Keys.COMMON_PKG_VERSIONCODE] = packageInfo.version
      ..[Keys.COMMON_PKG_NAME] = packageInfo.packageName
      ..[Keys.COMMON_NET_TYPE] = await getNetworkStatus()
      ..[Keys.COMMON_SCREEN_SIZE] =
          '${UIUtils.screenWidth! * (UIUtils.pixelRatio ?? 1.0)}，${UIUtils.screenHeight! * (UIUtils.pixelRatio ?? 1.0)}'
      ..[Keys.COMMON_DEVICE_DENSITY] = UIUtils.pixelRatio ?? -1
      ..[Keys.COMMON_CARRIER] = ''
      ..[Keys.COMMON_LOCAL_CITY] = ''
      ..[Keys.COMMON_LANGUAGE] = 'zh_CN'
      ..[Keys.COMMON_CHL_PRELOAD] = ''
      ..[Keys.COMMON_PROTOCOL_CODE] = ''
      ..[Keys.COMMON_UI_VER] = Strings.UI_VER
      ..[Keys.COMMON_IMEI] = ''
      ..[Keys.COMMON_OAID] = '';

    if (Platform.isAndroid) {
      var androidInfo = await getAndroidInfo();

      queryMap
        ..[Keys.COMMON_DEV_NO] = androidInfo.androidId
        ..[Keys.COMMON_BRAND] = androidInfo.brand
        ..[Keys.COMMON_DEV_NAME] = androidInfo.model
        ..[Keys.COMMON_OS_TYPE] = 2
        ..[Keys.COMMON_OS_VER] = androidInfo.version.release
        ..[Keys.COMMON_CHL] = Strings.CHANNEL_ID_ANDROID
        ..[Keys.COMMON_ANDROID_ID] = androidInfo.androidId
        ..[Keys.COMMON_APP_ID] = Strings.APP_ID_ANDROID
        ..[Keys.COMMON_ZM_ID] = await _getZMId();
    } else {
      var iosInfo = await getIOSDeviceInfo();
      queryMap
        ..[Keys.COMMON_DEV_NO] = iosInfo.identifierForVendor
        ..[Keys.COMMON_BRAND] = 'apple'
        ..[Keys.COMMON_DEV_NAME] = iosInfo.name
        ..[Keys.COMMON_OS_TYPE] = 1
        ..[Keys.COMMON_OS_VER] = iosInfo.systemVersion
        ..[Keys.COMMON_CHL] = Strings.CHANNEL_ID_IOS
        ..[Keys.COMMON_ANDROID_ID] = ''
        ..[Keys.COMMON_APP_ID] = Strings.APP_ID_IOS
        ..[Keys.COMMON_ZM_ID] = '';
    }
    return queryMap;
  }

  /*Sample:
   {version.securityPatch: 2020-11-01,
    version.sdkInt: 29, 
    version.release: 10,
    version.previewSdkInt: 0,
    version.incremental: 11.0.0.179C00,
    version.codename: REL,
    version.baseOS: ,
    board: OXF,
    bootloader: unknown,
    brand: HONOR,
    device: HWOXF,
    display: OXF-AN00 4.0.0.179(C00E177R3P5),
    fingerprint: HONOR/OXF-AN00/HWOXF:10/HUAWEIOXF-AN00/11.0.0.179C00:user/release-keys,
    hardware: kirin990,
    host: system208-122,
    id: HUAWEIOXF-AN00,
    manufacturer: HUAWEI,
    model: OXF-AN00,
    product: OXF-AN00,
    supported32BitAbis: [armeabi-v7a, armeabi],
    supported64BitAbis: [arm64-v8a],
    supportedAbis: [arm64-v8a, armeabi-v7a, armeabi],
    tags: release-keys, type: user,
    isPhysicalDevice: true,
    androidId: d04b681bf64e7b48}
   */
  static Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId
    };
  }

  /*Sample:
   {name: iPhone 12 Pro Max,
    systemName: iOS,
    systemVersion: 14.5,
    model: iPhone,
    localizedModel: iPhone,
    identifierForVendor: 5C67070B-9C03-459B-AEC4-B5710BB551D4,
    isPhysicalDevice: false,
    utsname.sysname:: Darwin,
    utsname.nodename:: zuimeideiMac.local,
    utsname.release:: 20.3.0,
    utsname.version:: Darwin Kernel Version 20.3.0: Thu Jan 21 00:07:06 PST 2021;
    root:xnu-7195.81.3~1/RELEASE_X86_64,
    utsname.machine:: x86_64}
  */
  static Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  static Future<int> getNetworkStatus() async {
    var networkInfo = await (Connectivity().checkConnectivity());
    var networkStatusCode = -1;
    switch (networkInfo) {
      case ConnectivityResult.wifi:
        networkStatusCode = 1;
        break;
      case ConnectivityResult.mobile:
        networkStatusCode = 4;
        break;
      case ConnectivityResult.none:
        networkStatusCode = 0;
        break;
    }
    return networkStatusCode;
  }

  static Future<String> _getZMId() async {
    /* if (TextUtils.isEmpty(sZmId)) {
                String brand = Build.BRAND;
                String model = Build.MODEL;
                String serialNum = Build.UNKNOWN;
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    if (ActivityCompat.checkSelfPermission(context, Manifest.permission.READ_PHONE_STATE)
                            == PackageManager.PERMISSION_GRANTED) {
                        serialNum = Build.getSerial();
                    }
                } else {
                    serialNum = Build.SERIAL;
                }
                String androidId = getAndroidId(context);
                sZmId = MD5Util.getStringMD5(brand + model + serialNum + androidId);*/
    var androidInfo = await getAndroidInfo();

    String serialNum = 'unknown';

    String androidId = androidInfo.androidId;
    return EncodeUtil.generateMd5(
        '${androidInfo.brand}${androidInfo.model}$serialNum$androidId');
  }
}
