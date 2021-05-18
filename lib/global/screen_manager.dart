import 'package:get/get.dart';

class ScreenManager {
  List<String> _screenStack = <String>[];

  ScreenManager._internal();

  static ScreenManager _singleton = ScreenManager._internal();

  //工厂模式
  factory ScreenManager() => _singleton;

  void addScreen(GetxController screen) {
    _screenStack.add(screen.runtimeType.toString());
  }

  void removeScreen(GetxController screen) {
    _screenStack.remove(screen.runtimeType.toString());
  }

  bool isTopPage(GetxController screen) {
  
    try {
      return screen.runtimeType.toString() == _screenStack[_screenStack.length - 1];
    } catch (exception) {
      return false;
    }
  }

  bool isSecondTop(GetxController screen) {
   
    try {
      return screen.runtimeType.toString() == _screenStack[_screenStack.length - 2];
    } catch (exception) {
      return false;
    }
  }
}