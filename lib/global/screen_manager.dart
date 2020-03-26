import 'package:fluttermvvmframe/base/base.dart';

class ScreenManager {
  List<String> _screenStack = List<String>();

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
    if (_screenStack == null) {
      return false;
    }
    try {
      return state.getWidgetName() == _screenStack[_screenStack.length - 1];
    } catch (exception) {
      return false;
    }
  }

  bool isSecondTop(BaseState state) {
    if (_screenStack == null) {
      return false;
    }
    try {
      return state.getWidgetName() == _screenStack[_screenStack.length - 2];
    } catch (exception) {
      return false;
    }
  }
}