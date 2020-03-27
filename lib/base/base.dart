import 'dart:async';

import 'package:dartin/dartin.dart';
import 'package:easy_toast/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_frame/global/screen_manager.dart';
import 'package:flutter_mvvm_frame/utils/log_util.dart';
import 'package:flutter_mvvm_frame/utils/ui_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:provider/provider.dart';

///VM基类
class BaseProvider extends ChangeNotifier {
  CompositeSubscription compositeSubscription = CompositeSubscription();

  addSubscription(StreamSubscription subscription) {
    compositeSubscription.add(subscription);
  }

  @override
  void dispose() {
    if (!compositeSubscription.isDisposed) {
      compositeSubscription.dispose();
    }
    super.dispose();
  }
}

///V基类
abstract class BaseScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => getState();

  BaseState getState();
}

abstract class BaseState<T extends BaseScreen,P extends BaseProvider> //不用VM可传入BaseProvider
  extends State<T>
  with WidgetsBindingObserver, BaseTools, AutomaticKeepAliveClientMixin {
  bool _isResumed = false;
  bool _isPaused = false;
  List<StreamSubscription> subscriptions = List();
  P mProvider;

  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Global.currContext = context;

    if (!UIUtils.initialized) {
      UIUtils.init(context);
    }

    if (!_isResumed) {
      //说明是 初次加载
      if (ScreenManager().isTopPage(this)) {
        _isResumed = true;
        onResume();
      }
    }
    //executeAfterBuild();
    return ChangeNotifierProvider<P>(
      create: (context) => mProvider = inject<P>(), ///在此注入VM
      child: getWidget(context),
    );
  }

  Future<void> executeAfterBuild() async {
    onBuilt();
  }

  Widget getWidget(BuildContext context);

  String getWidgetName() {
    if (this.widget != null) {
      return this.widget.toString();
    } else {
      return "";
    }
  }

  //===================================生命周期处理===================================

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); //监听state生命周期
    ScreenManager().addWidget(this);
    initView();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    //LogUtil.v('didChangeAppLifecycleState ->${getWidgetName()}');
    switch (state) {
      case AppLifecycleState.resumed:
        if (ScreenManager().isTopPage(this)) {
          onForeground();
          onResume();
        }
        break;
      case AppLifecycleState.paused:
        if (ScreenManager().isTopPage(this)) {
          onBackground();
          onPause();
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    if (ScreenManager().isSecondTop(this)) {
      LogUtil.v('${getWidgetName()} is on second top');
      if (!_isPaused) {
        onPause();
        _isPaused = true;
      } else {
        onResume();
        _isPaused = false;
      }
    } else if (ScreenManager().isTopPage(this)) {
      LogUtil.v('${getWidgetName()} is on top');
      if (!_isPaused) {
        onPause();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _isPaused = false;
    _isResumed = false;
    onDestroy();
    WidgetsBinding.instance.removeObserver(this);
    ScreenManager().removeWidget(this);
    //取消订阅
    if (subscriptions.isNotEmpty) {
      subscriptions.forEach((subscription) {
        subscription.cancel();
        subscriptions.clear();
      });
    }
  }

//================================子类工具方法===================================

}

abstract class BaseTools {

  void initView() {
  }

  void onBuilt() {
  }

  void onResume() {
  }

  void onPause() {
  }

  void onDestroy() {
  }

  void onForeground() {
  }

  void onBackground() {
  }
}
