import 'package:flutter/material.dart';
import 'package:flutter_mvvm_frame/global/dependencies_module.dart';
import 'package:flutter_mvvm_frame/module/view/home.dart';
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
