import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_frame/module/view/home.dart';

final routes = <String, WidgetBuilder>{ //泛型参数用来规范json中键值对的类型
  //DetailPage0.route: (context,{args = '默认标题'}) => DetailPage0(args: args),
  //DetailPage1.route: (context) => DetailPage1(),
  HomeScreen.route: (context) => HomeScreen(),
};

Route? generateRoute(RouteSettings settings) {
  final String? name = settings.name; //生成路由时会走该方法 获取当前路由名称
  final Function? pageContentBuilder = routes[name!]; //根据路由名称拿到路由生成器方法（在json中注册的）

  if (pageContentBuilder != null) {
    if (settings.arguments != null) { //有参
      return MaterialPageRoute(
        builder: (context) =>
          pageContentBuilder(context,args: settings.arguments));
    } else {
      return MaterialPageRoute(
        builder: (context) => pageContentBuilder(context));
    }
  } else { //拿不到
    return null;
  }
}

