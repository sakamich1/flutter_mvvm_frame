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
}

class Strings {
}

///示例：必须加入alpha
class Iro {
  ///gray
  static const int gray1 = 0xff333333;

  ///gray with alpha
  static const int gray1t = 0x99080808;

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
