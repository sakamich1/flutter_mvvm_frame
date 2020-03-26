import 'package:easy_toast/easy_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttermvvmframe/base/base.dart';
import 'package:fluttermvvmframe/utils/extensions.dart';

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
            onPressed: () => toast('DO NOT FUCKING PRESS ME'),
          ),
        ],
      ),
    );

}

