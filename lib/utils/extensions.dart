import 'dart:ui';

import 'package:ai_paint/common/constants.dart';
import 'package:ai_paint/utils/ui_utils.dart';

extension StringExtension on String{
  /// 是否是电话号码
  bool isMobileNumber() {
    if (this.isNotEmpty == true) {
      return RegExp(
        r'^((13[0-9])|(14[5,7,9])|(15[^4])|(18[0-9])|(17[0,1,3,5,6,7,8])|(19)[0-9])\d{8}$')
        .hasMatch(this);
    }
    return false;
  }

}

extension ListStringExt on List<String>{
  ///数组转字符串
  String listToString({String split = " "}) {
    var sb = StringBuffer();
    this.asMap().forEach((element,index) {
      sb.write(element);
      if (index != this.length - 1) {
        sb.write(split);
      }
    });
    return sb.toString();
  }
}

extension IntExt on int{
  ///px转dp
  double get px =>
    Configurations.fitWidth ?
    this * (window.physicalSize.width / Configurations.design_width_px) //先缩放（1080下就是x1.44）
      / window.devicePixelRatio// 除以本机像素密度获取dp
    :
    this * (window.physicalSize.height / Configurations.design_height_px)
      / window.devicePixelRatio;

  ///根据像素密度比转换dp
  double get dp =>
    Configurations.fitWidth ?
    (this * Configurations.design_density) * //获取到设计图px
      (window.physicalSize.width / Configurations.design_width_px)// 乘以缩放因子
      / window.devicePixelRatio //除以本机像素密度获取dp
    :
    (this * Configurations.design_density) *
      (window.physicalSize.height / Configurations.design_height_px) /
      window.devicePixelRatio;

  ///字体专用单位 可控制缩放
  double get sp {
    if (Configurations.fitWidth) {
      if (Configurations.applySystemFontScaling) {
        return (this * Configurations.design_density) //获取到设计图px
          * (window.physicalSize.width
            / Configurations.design_width_px) // 乘以缩放因子
          / window.devicePixelRatio; //除以本机像素密度获取dp
      } else {
        return (this * Configurations.design_density) //获取到设计图px
          * (window.physicalSize.width
            / Configurations.design_width_px) / // 乘以缩放因子
          window.devicePixelRatio //除以本机像素密度获取dp
          / UIUtils.textScaleFactor; //除以系统字体缩放因子，放大多少就缩小多少233
      }
    } else {
      if (Configurations.applySystemFontScaling) {
        return (this * Configurations.design_density)
          * (window.physicalSize.height
            / Configurations.design_height_px)
          / window.devicePixelRatio;
      } else {
        return (this * Configurations.design_density)
          * (window.physicalSize.height
            / Configurations.design_height_px)
          / window.devicePixelRatio
          / UIUtils.textScaleFactor;
      }
    }
  }
}