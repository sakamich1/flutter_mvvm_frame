import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mvvm_frame/base/base.dart';
import 'package:get/get.dart';
import '../../r.g.dart';
import 'home_controller.dart';

class HomeScreen extends BaseScreen<HomeController> {
  @override
  Widget getWidget(BuildContext context) => Scaffold(
        body: Container(),
      );
}
