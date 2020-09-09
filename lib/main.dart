import 'package:flutter/material.dart';
import 'package:wanandroid/model/baseModel.dart';
import 'package:wanandroid/model/demoModel.dart';
import 'package:wanandroid/network/networkManager.dart';
import './pages/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      home: MainPage(),
    );
  }
}
