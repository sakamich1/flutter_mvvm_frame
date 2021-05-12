import 'package:flutter_mvvm_frame/base/base.dart';

class ScreenManager {
  List<String> _screenStack = <String>[];

  ScreenManager._internal();

  static ScreenManager _singleton = ScreenManager._internal();

  //工厂模式
  factory ScreenManager() => _singleton;

  void addWidget(BaseState state) {
    _screenStack.add(state.getWidgetName());
  }

  void removeWidget(BaseState state) {
    _screenStack.remove(state.getWidgetName());
  }

  bool isTopPage(BaseState state) {
  
    try {
      return state.getWidgetName() == _screenStack[_screenStack.length - 1];
    } catch (exception) {
      return false;
    }
  }

  bool isSecondTop(BaseState state) {
   
    try {
      return state.getWidgetName() == _screenStack[_screenStack.length - 2];
    } catch (exception) {
      return false;
    }
  }
}