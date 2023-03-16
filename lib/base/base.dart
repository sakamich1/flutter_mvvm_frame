import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ai_paint/global/screen_manager.dart';
import 'package:ai_paint/utils/ui_utils.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';


///V层基类
abstract class BaseScreen<T> extends GetView<T> {
  bool get isLockVertical => true;

  @override
  Widget build(BuildContext context) {
    if (!UIUtils.initialized) {
      UIUtils.init(context);
    }

    if(isLockVertical){
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp, //只能纵向
        //DeviceOrientation.portraitDown,//只能纵向
      ]);
    }
    
    return getWidget(context);
  }

  Widget getWidget(BuildContext context);
}

///GetXController基类
abstract class BaseController extends SuperController{
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onDetached() {
  }

  @override
  void onInactive() {
  }

  @override
  void onPaused() {
  }

  @override
  void onResumed() {
  }


}



