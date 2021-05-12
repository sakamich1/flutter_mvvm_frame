import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mvvm_frame/base/base.dart';
import 'package:flutter_mvvm_frame/utils/extensions.dart';

class HomeScreen extends BaseScreen {
  static final route = '/';

  @override
  BaseState<BaseScreen,BaseProvider> getState() => _HomeState();
}

class _HomeState extends BaseState<HomeScreen,BaseProvider> {
  @override
  Widget getWidget(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('Frame'),
        backgroundColor: Colors.tealAccent,
        leading: Icon(Icons.menu),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
          ),
        ],
      ),
    );

}

