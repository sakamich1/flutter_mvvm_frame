import 'package:flutter/material.dart';
import 'package:fluttermvvmframe/global/dependencies_module.dart';
import 'package:fluttermvvmframe/module/view/home.dart';
import 'package:fluttermvvmframe/utils/ui_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/constants.dart';
import 'global/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      initialRoute: HomeScreen.route,
      onGenerateRoute: generateRoute,
    );
  }
}
