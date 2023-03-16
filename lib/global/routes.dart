import 'package:ai_paint/module/home/home.dart';
import 'package:ai_paint/module/home/home_binding.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRouter {
  static const MAIN = 'main';
  static const HOME = '/home';

  static final routes = [

    GetPage(
      name: HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
