import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid/service_method/home/home_network.dart';
import '../model/reposTreeModel.dart';
import '../widget/recoTreePage.dart';
import '../widget/wxArticleTreePage.dart';

enum Treetype {
  recorepos,
  wxarticles,
}

// ignore: must_be_immutable
class ReposTree extends StatefulWidget {
  Treetype type;
  ReposTree(this.type, {Key key}) : super(key: key);

  @override
  _ReposTreeState createState() => _ReposTreeState();
}

class _ReposTreeState extends State<ReposTree> with TickerProviderStateMixin {
  List<ReposTreeCellModel> _titles = [];
  TabController _tabController;

  //var _futureBuildFuture;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _titles.length, vsync: this);

    int urlType = widget.type == Treetype.recorepos ? 1 : 2;
    getTreesList(urlType).then((value) {
      ReposTreeModel treeModel = ReposTreeModel.fromJson(value);
      setState(() {
        _titles.addAll(treeModel.data);
        _tabController = TabController(length: _titles.length, vsync: this);
      });
    });

    //_futureBuildFuture = getReposTreeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.type == Treetype.recorepos
            ? Text("Repos Tree")
            : Text("Wx Article"),
        bottom: _tabbarWidget(),
      ),
      body: _bodyWidget(),
    );
    // return FutureBuilder(
    //   future: _futureBuildFuture,
    //   builder: (context, snapshot) {
    //     print("build-build-build");
    //     if (snapshot.hasData) {
    //       ReposTreeModel treeModel = ReposTreeModel.fromJson(snapshot.data);
    //       _titles.addAll(treeModel.data);
    //     }
    //     return DefaultTabController(
    //       length: _titles.length,
    //       child: Scaffold(
    //         appBar: AppBar(
    //           title: Text("Repos Tree"),
    //           bottom: _tabbarWidget(),
    //         ),
    //         body: _bodyWidget(),
    //       ),
    //     );
    //   },
    // );
  }

  //tabbar
  _tabbarWidget() {
    if (_titles.length == 0) {
      return null;
    } else {
      return TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: _titlesWidget(),
      );
    }
  }

  //Tab结合
  List<Widget> _titlesWidget() {
    List<Widget> tabs = [];
    _titles.map((e) {
      tabs.add(Tab(
        text: e.name,
      ));
    }).toList();
    return tabs;
  }

  //body
  _bodyWidget() {
    if (_titles.length == 0) {
      return Center(
        child: SizedBox(
          width: 60.w,
          height: 60.w,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    } else {
      return TabBarView(
        controller: _tabController,
        children: _tabbarviewChild(),
      );
    }
  }

  //当前分类详情列表
  List<Widget> _tabbarviewChild() {
    List<Widget> l = [];

    _titles.map((e) {
      if (widget.type == Treetype.recorepos) {
        l.add(RecoTreePage(e.id));
      } else {
        l.add(WXArticleTreePage(e.id));
      }
    }).toList();
    return l;
  }
}
