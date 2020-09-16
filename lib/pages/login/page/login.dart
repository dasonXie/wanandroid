import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wanandroid/pages/login/page/register.dart';
import 'package:wanandroid/pages/login/widget/inputTextField.dart';
import 'package:wanandroid/pages/login/widget/wholeButton.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        loginView(),
      ],
    );
  }

  loginView() {
    return Column(
      children: [
        Expanded(
          //用于上下平分
          child: Container(),
        ),
        Expanded(child: loginTextView())
      ],
    );
  }

  loginTextView() {
    return Column(
      children: [
        InputTextField(Icons.person, Colors.purpleAccent,
            hintText: "user name"),
        InputTextField(Icons.lock, Colors.purpleAccent,
            hintText: "password", obscureText: true),
        Row(
          children: [
            Expanded(
              child: Container(),
            ),
            FlatButton(
              child: Text("Forget the password?",
                  style: TextStyle(
                    color: Colors.grey,
                  )),
              onPressed: () {
                print("忘记密码");
              },
            )
          ],
        ),
        WholeButton(
          Text(
            "Login",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          onPressedFunc: () {
            print("登录");
          },
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.purple,
          ),
        ),
        FlatButton(
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "New user?",
                style: TextStyle(color: Colors.grey),
              ),
              TextSpan(
                text: " Register",
                style: TextStyle(color: Colors.purple),
              ),
            ]),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => RegisterPage()));
          },
        )
      ],
    );
  }
}
