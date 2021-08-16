import 'package:shared_preferences/shared_preferences.dart';

class Configurations {
  static const int connect_time_out = 10000;
  static const int receive_time_out = 10000;
  static const String base_url = "";

  ///设计稿宽高像素
  static const int design_width_px = 750;
  static const int design_height_px = 1334;

  ///设计稿像素密度（一般6s）
  static const int design_density = 2;

  ///适配宽or高
  static const bool fitWidth = true;

  ///是否应用系统字体缩放
  static const bool applySystemFontScaling = true;
}

class API {
  static const String URL_REPORT = '';
}

class Strings {
  static const String UI_VER = 'huawei';
  static const String APP_ID_ANDROID = '';
  static const String CHANNEL_ID_ANDROID = '';
  static const String APP_ID_IOS = '';
  static const String CHANNEL_ID_IOS = '';
  static const String API_KEY = '';

  //static const String API_KEY = '2e3d7e2d33d5335137f1a5fdee0892fc';
  static const String PROTO_ENCRYPT_KEY = "zmtq";
}

class Keys {
  //串号
  static const String COMMON_DEV_NO = 'devNo';

  //品牌
  static const String COMMON_BRAND = 'brand';

  //型号
  static const String COMMON_DEV_NAME = 'devName';

  //设备类型，填Android
  static const String COMMON_OS_TYPE = 'osType';

  //系统版本
  static const String COMMON_OS_VER = 'osVer';

  //软件版本
  static const String COMMON_SOFT_VER = 'softVer';

  //网络类型
  static const String COMMON_NET_TYPE = 'netType';

  //运营商类型
  static const String COMMON_CARRIER = 'operation';

  //渠道号
  static const String COMMON_CHL = 'chl';

  //
  static const String COMMON_CHL_PRELOAD = 'chlPreload';

  //定位城市ID
  static const String COMMON_LOCAL_CITY = 'locationCity';

  //屏幕尺寸
  static const String COMMON_SCREEN_SIZE = 'reso';

  //协议码
  static const String COMMON_PROTOCOL_CODE = 'procCode';

  //密度值
  static const String COMMON_DEVICE_DENSITY = 'devDensity';

  //androidid
  static const String COMMON_ANDROID_ID = 'androidId';

  //语言、从设备里读出来的数据
  static const String COMMON_LANGUAGE = 'language';

  //ver版本类型
  static const String COMMON_UI_VER = 'uiVer';

  //包名
  static const String COMMON_PKG_NAME = 'pkgName';

  //versionCode
  static const String COMMON_PKG_VERSIONCODE = 'versionCode';

  // user id
  static const String COMMON_USER_ID = 'userId';

  // app id
  static const String COMMON_APP_ID = 'appId';

  // zm 唯一id
  static const String COMMON_ZM_ID = 'zmId';

  //定位城市纬度
  static const String COMMON_CITY_LATITUDE = 'locationLat';

  //定位城市经度
  static const String COMMON_CITY_LONGITUDE = 'locationLong';

  static const String COMMON_IMEI = 'imei';

  static const String COMMON_OAID = 'oaid';

  static const String COMMON_KEY_IDFA = 'idfa';

  static const String COMMON_KEY_VENDOR = 'vendor';

  ///========================================== 以上为公共参数key ==========================================

  ///apikey 字幕k根据接口不同区分大小写
  static const String KEY_API_KEY_LOW_CASE = 'apikey';
  static const String KEY_API_KEY_CAMEL = 'apiKey';

  ///定位系统
  static const String KEY_LOCATION_SYSTEM = 'locationSystem';

  ///协议码
  static const String KEY_PROTOCOL_CODE = 'procCode';

  static const String KEY_CITY_CODE = 'cityCode';
  static const String KEY_CITY_CODE_LOW_CASE = 'citycode';
  static const String KEY_CITY_CODES = 'cityCodes';

  ///主数据
  static const String KEY_API_CITY = "city";
  static const String KEY_API_DISTRICT = "district";
  static const String KEY_API_PROVINCE = "province";
  static const String KEY_API_IP = "ip";
  static const String KEY_API_AOI_NAME = "aoiName";
  static const String KEY_API_AUTO = "auto";
  static const String KEY_API_LOGS = "logs";

  ///搜索城市
  static const String KEY_API_SEARCH_KEY = 'q';
  static const String KEY_API_SEARCH_LANGUAGE = 'language';
  
  ///========================================== 上报接口参数 ==========================================

  static const String REPORT_KEY_EVENT_ID='event';

  static const String REPORT_KEY_OS = 'os';

  static const String REPORT_KEY_OS_VER = 'os_version';

  static const String REPORT_KEY_DEV_NO = 'dev_no';

  static const String REPORT_KEY_MODEL = 'model';

  static const String REPORT_KEY_CHANNEL = 'channel';

  static const String REPORT_KEY_ANDROID_ID = 'androidid';

  static const String REPORT_KEY_APP_ID = 'app_id';

  static const String REPORT_KEY_PACKAGE_NAME = 'pkg';

  static const String REPORT_KEY_NETWORK = 'network';

  static const String REPORT_KEY_LAT = 'latitude';

  static const String REPORT_KEY_LON = 'longitude';

  static const String REPORT_APP_VER='app_ver';
}

class SPKeys {
  static const String KEY_LOCATION_DATA = 'key_location_data';
}

///示例：必须加入alpha
class Iro {
  ///gray
  static const int gray1 = 0xff333333;
  static const int color_bg_toast = 0xf2ececec;

  ///orange
  static const int orange1 = 0xfff96006;

  ///blue
  static const int blue1 = 0xff4a90e2;

  ///gold
  static const int gold1 = 0xfffde3ae;

  ///red
  static const int red1 = 0xfff16859;

  ///yellow
  static const int yellow1 = 0xfffce374;

  ///green
  static const int green1 = 0xff6fe457;

  ///pink
  static const int pink1 = 0xfffff3ec;

  ///purple
  static const int purple1 = 0xff9c08ef;
}
