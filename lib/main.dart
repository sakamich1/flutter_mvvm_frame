import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm_frame/module/home/home.dart';
import 'package:flutter_mvvm_frame/request/http_manager.dart';
import 'package:get/get.dart';
import 'global/app_theme.dart';
import 'global/dependencies_module.dart';
import 'global/routes.dart';
import 'module/home/home_binding.dart';
import 'r.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(GetMaterialApp(
    initialRoute: AppRouter.HOME,
    builder: (context, child) => Scaffold(
      // Global GestureDetector that will dismiss the keyboard
      body: GestureDetector(
        onTap: () {
          hideKeyboard(context);
        },
        child: child,
      ),
    ),
    theme: appThemeData,
    defaultTransition: Transition.fade,
    getPages: AppRouter.routes,
    initialBinding: HomeBinding(),
    home: HomeScreen(),
  ));

  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}
