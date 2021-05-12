import 'dart:ui';

import 'package:flutter/cupertino.dart';

class UIUtils {
  static late MediaQueryData _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? pixelRatio;
  static double? statusBarHeight;
  static double? bottomBarHeight;
  static late double textScaleFactor;
  static bool initialized = false;

  static void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    _mediaQueryData = mediaQuery;
    pixelRatio = mediaQuery.devicePixelRatio;
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    statusBarHeight = mediaQuery.padding.top;
    bottomBarHeight = _mediaQueryData.padding.bottom;
    textScaleFactor = mediaQuery.textScaleFactor;
    initialized = true;
  }

}