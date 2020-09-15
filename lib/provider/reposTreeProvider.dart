import 'package:flutter/material.dart';
import '../pages/home/model/reposTreeModel.dart';
import '../service_method/home/home_network.dart';

class ReposTreeProvider extends ChangeNotifier {
  //分类列表
  List<ReposTreeCellModel> _titles = [];

  List<ReposTreeCellModel> get titles => _titles;
  //分类总数量
  int get titlesNum => this.titles.length;
  //默认分类
  ReposTreeCellModel currentTreeModel;

  //请求分类列表数据
  getTreesList() {
    getReposTreeList().then((value) {
      ReposTreeModel treeModel = ReposTreeModel.fromJson(value);
      titles.addAll(treeModel.data);
      this.currentTreeModel = titles.length != 0 ? titles.first : null;
      notifyListeners();
    });
  }

  //请求当前分类详情列表数据
  getCurrentTreeDetailList() {
    if (this.currentTreeModel != null) {
      getReposList(cid: this.currentTreeModel.id).then((value) {
        print("当前分类列表详情\n*******\n $value");
        notifyListeners();
      });
    }
  }

  List<Widget> scrollTitles() {
    List<Widget> tabs = [];
    this.titles.map((e) {
      tabs.add(Tab(
        text: e.name,
      ));
    }).toList();
    return tabs;
  }
}
