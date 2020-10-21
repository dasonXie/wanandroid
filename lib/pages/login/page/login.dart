import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wanandroid/config/config.dart';
// import 'package:wanandroid/model/baseModel.dart';
// import 'package:wanandroid/network/api.dart';
// import 'package:wanandroid/config/netWorkConfig.dart';
// import 'package:wanandroid/network/networkManager.dart';
// import 'package:wanandroid/pages/login/model/userModel.dart';
import 'package:wanandroid/pages/login/page/register.dart';
import 'package:wanandroid/pages/login/widget/inputTextField.dart';
import 'package:wanandroid/pages/login/widget/wholeButton.dart';
import 'package:wanandroid/user/userManager.dart';
import 'package:wanandroid/utils/toast.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController accountController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

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
        InputTextField(
          Icons.person,
          Colors.purple,
          hintText: "user name",
          controller: accountController,
        ),
        InputTextField(
          Icons.lock,
          Colors.purple,
          hintText: "password",
          obscureText: true,
          controller: pwdController,
        ),
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
          onPressedFunc: (context) => loginAction(context),
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

//登录事件
  loginAction(context) async {
    final account = this.accountController.text;
    if (account.isEmpty || account.length < 6) {
      Toast.show(context, "请输入至少6位用户名");
      return;
    }

    final pwd = this.pwdController.text;
    if (pwd.isEmpty || pwd.length < 6) {
      Toast.show(context, "请输入至少6位密码");
      return;
    }

    //网络请求
    UserManager.instance.login(account, pwd, () {
      Navigator.of(context).pushReplacementNamed("route_main");
    }, () {
      print("登录失败了");
    });
  }
}
