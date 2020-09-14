import 'package:flutter/material.dart';
import 'package:wanandroid/pages/system/model/systemModel.dart';

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
      tabs.add(Text(model.name));
    }
    return tabs;
  }
}
