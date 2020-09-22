import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid/config/netWorkConfig.dart';
import 'package:wanandroid/pages/repos/page/repos_page.dart';
import 'package:wanandroid/user/userManager.dart';
import 'home/page/home_page.dart';
import 'events_page.dart';
import 'system/page/system_page.dart';
import 'drawer_page.dart';
import 'search_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final List<Widget> _tabs = [
  Tab(text: "Home"),
  Tab(text: "Repos"),
  Tab(text: "Events"),
  Tab(text: "System")
];

final List<Widget> _pages = [
  HomePage(),
  ReposPage(),
  EventPage(),
  SystemPage()
];

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    createNetWorkConfig();
    createUserInfo();
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: LeftIcon(),
          actions: <Widget>[
            RightIcon(),
          ],
          title: TabbarTools(),
        ),
        body: TabBarView(
          children: _pages,
        ),
        drawer: Drawer(
          child: DrawerPage(),
        ),
      ),
    );
  }

//初始化网络配置
  createNetWorkConfig() async {
    NetworkConfig.instance.errorCallBack =
        (code, msg) => errorCallBack(code, msg);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cookie = prefs.getString("Cookie");

    NetworkConfig.instance..headers["Cookie"] = cookie;
  }

  errorCallBack(int code, String msg) {
    print("code:" + code.toString() + "   msg" + msg);
  }

  //初始化用户信息
  createUserInfo() {
    UserManager.instance;
  }
}

//图像按钮
class LeftIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.account_circle),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}

//搜索按钮
class RightIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return SearchPage();
          },
        ));
      },
    );
  }
}

//tabbar
class TabbarTools extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicator: BoxDecoration(),
      isScrollable: true,
      labelPadding: EdgeInsets.all(10),
      tabs: _tabs,
    );
  }
}
