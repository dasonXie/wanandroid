import 'package:flutter/material.dart';
import 'package:wanandroid/user/userManager.dart';

import 'login/page/login.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Padding(
              padding: EdgeInsets.only(top: 60), child: loginOrlogout(context)),
        )
      ],
    );
  }

  Widget loginOrlogout(BuildContext context) {
    if (UserManager.instance.isLogin()) {
      return InkWell(
        child: Text("退出"),
        onTap: () {
          _showLoginOutDialog(context);
        },
      );
    } else {
      return InkWell(
        child: Text("登录"),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => LoginPage()));
        },
      );
    }
  }

  void _showLoginOutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: Text(
              "确定退出吗？",
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  Navigator.pop(ctx);
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () {
                  UserManager.instance.logout(() {
                    Navigator.pop(ctx);
                    Navigator.pop(context);
                  }, () {
                    print("退出失败");
                  });
                },
              ),
            ],
          );
        });
  }

  loginOut() {
    //退出登录
  }
}
