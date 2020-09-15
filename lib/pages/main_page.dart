import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wanandroid/pages/repos/page/repos_page.dart';
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

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    //默认按750的尺寸布局
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
