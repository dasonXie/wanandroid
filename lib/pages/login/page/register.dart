import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wanandroid/pages/login/widget/inputTextField.dart';
import 'package:wanandroid/pages/login/widget/wholeButton.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: containView(),
    );
  }

  containView() {
    return Stack(
      children: [
        Image.asset("assets/images/ic_login_bg.png"),
        Column(
          children: [
            Expanded(
              child: Container(),
            ),
            Expanded(child: loginTextField())
          ],
        )
      ],
    );
  }

  loginTextField() {
    return Column(children: [
      InputTextField(Icons.person, Colors.purpleAccent, hintText: "user name"),
      InputTextField(Icons.lock, Colors.purpleAccent,
          hintText: "password", obscureText: true),
      InputTextField(Icons.lock, Colors.purpleAccent,
          hintText: "confirm password", obscureText: true),
      SizedBox(
        height: 10,
      ),
      WholeButton(
        Text(
          "Register",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        onPressedFunc: (context) {
          print("注册");
        },
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.purple,
        ),
      ),
    ]);
  }
}
