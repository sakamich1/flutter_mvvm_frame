import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_frame/common/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UIUtils {
  static late MediaQueryData _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? pixelRatio;
  static double? statusBarHeight;
  static double? bottomBarHeight;
  static late double textScaleFactor;
  static bool initialized = false;
  static FToast? _fToast;
  static BuildContext? context;

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

  static void showToast(String msg,
      {toastLength = Toast.LENGTH_SHORT,
        double fontSize = 22,
        ToastGravity gravity = ToastGravity.CENTER}) {
    Fluttertoast.showToast(msg: msg, fontSize: fontSize, gravity: gravity);
  }

  static void showCustomToast(String msg,
      {double fontSize = 22, ToastGravity gravity = ToastGravity.CENTER}) {
    _fToast = FToast();
    _fToast!.init(context!);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(Iro.color_bg_toast),
      ),
      child: Text(
        msg,
        style: TextStyle(fontSize: fontSize, color: Colors.black)
        ,
      ),
    );

    _fToast?.showToast(
        child: toast,
        gravity: gravity,
        toastDuration: Duration(milliseconds: 2000));
  }

}