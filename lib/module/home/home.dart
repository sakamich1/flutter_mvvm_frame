import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mvvm_frame/base/base.dart';
import 'package:get/get.dart';
import '../../r.g.dart';
import 'home_controller.dart';

class HomeScreen extends BaseScreen<HomeController> {
  @override
  Widget getWidget(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: GetX<HomeController>(
              builder: (controller) => Text('${controller.text}')),
          backgroundColor: Colors.tealAccent,
          leading: Icon(Icons.menu),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                controller.changeText();
              },
            ),
          ],
        ),
        body: Container(
          child: Image(
            image: R.image.flr_test_jpg_1_jpg(),
          ),
        ),
      );
}
