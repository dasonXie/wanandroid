import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/pages/system/model/systemModel.dart';
import 'package:wanandroid/pages/system/page/system_tab_page.dart';
import 'package:wanandroid/pages/system/viewModel/system_tab_viewModel.dart';

class SystemTab extends StatelessWidget {
  final SystemModel modelGroup;
  const SystemTab(this.modelGroup, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: modelGroup.children.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(modelGroup.name),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            tabs: tabList(),
          ),
        ),
        body: TabBarView(
          children: pageList(),
        ),
      ),
    );
  }

  tabList() {
    List<Widget> tabs = List();
    for (var model in modelGroup.children) {
      tabs.add(Tab(
        text: model.name,
      ));
    }
    return tabs;
  }

  pageList() {
    List<Widget> tabs = List();
    for (var model in modelGroup.children) {
      tabs.add(SystemTabPage(model.id.toString()));
    }
    return tabs;
  }
}
