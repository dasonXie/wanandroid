import 'package:flutter/material.dart';
// import 'package:wanandroid/pages/login/model/userModel.dart';
import 'package:wanandroid/pages/video/page/videoPage.dart';
import 'package:wanandroid/user/userManager.dart';

import 'login/page/login.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipOval(
                        child: Image.asset("assets/images/touxiang.jpg"),
                      ),
                    ),
                    Text(
                      UserManager.instance.model.username.isEmpty
                          ? "userName"
                          : UserManager.instance.model.username,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "个人简介",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                decoration: BoxDecoration(color: Colors.purple),
              ),
            ),
          ],
        ),
        loginOrlogout(context),
        SizedBox(
          height: 50,
        ),
        Center(
          child: InkWell(
            child: Text("视频"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return VideoPage();
                },
              ));
            },
            // onTap: () {
            //   //打开视频页面
            //   Navigator.of(context).push(MaterialPageRoute(
            //       builder: (BuildContext context) => VideoPage()));
            // },
          ),
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
