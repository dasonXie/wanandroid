import 'package:flutter/material.dart';
import 'package:wanandroid/model/baseModel.dart';
import 'package:wanandroid/model/demoModel.dart';
import 'package:wanandroid/network/networkManager.dart';
import './pages/main_page.dart';
import 'package:provider/provider.dart';
import './provider/reposTreeProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReposTreeProvider()),
      ],
      child: MaterialApp(
        title: "Flutter Demo",
        theme: ThemeData(
          primaryColor: Colors.purple,
        ),
        home: MainPage(),
      ),
    );
  }
}
