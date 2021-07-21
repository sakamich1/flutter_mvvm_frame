import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_frame/global/screen_manager.dart';
import 'package:flutter_mvvm_frame/utils/ui_utils.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';


///V层基类
abstract class BaseScreen<T> extends GetView<T> {
  @override
  Widget build(BuildContext context) {
    if (!UIUtils.initialized) {
      UIUtils.init(context);
    }
    return getWidget(context);
  }

  Widget getWidget(BuildContext context);
}

///GetXController基类
abstract class BaseController extends GetxController{
  CompositeSubscription compositeSubscription = CompositeSubscription();

  void addSubscription(StreamSubscription subscription) {
    compositeSubscription.add(subscription);
  }


  @override
  void onInit() {
    ScreenManager().addScreen(this);
    super.onInit();
  }

  @override
  void onClose() {
    ScreenManager().addScreen(this);
    if (!compositeSubscription.isDisposed) {
      compositeSubscription.dispose();
    }
    super.onClose();
  }

}



