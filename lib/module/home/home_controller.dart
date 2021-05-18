import 'dart:math';

import 'package:flutter_mvvm_frame/base/base.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  var text = "Frame".obs;

  void changeText() {
    text.value = "小亮整${Random().nextInt(999)}个活";
  }
}
