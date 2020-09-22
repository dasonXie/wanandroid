import 'package:flutter/material.dart';
import './pages/main_page.dart';
import 'package:provider/provider.dart';
import './provider/reposTreeProvider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
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
        routes: {
          "route_main": (ctx) => MainPage(),
        },
        title: "Flutter Demo",
        theme: ThemeData(
          primaryColor: Colors.purple,
        ),
        home: MainPage(),
      ),
    );
  }
}
