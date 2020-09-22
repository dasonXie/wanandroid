import 'package:flutter/material.dart';
import '../pages/home/model/reposTreeModel.dart';

class ReposTreeProvider extends ChangeNotifier {
  //分类列表
  List<ReposTreeCellModel> _titles = [];

  List<ReposTreeCellModel> get titles => _titles;
  //分类总数量
  int get titlesNum => this.titles.length;
  //默认分类
  ReposTreeCellModel currentTreeModel;
  String title = "你好";
  changeTitle() {
    title = "世界";
    notifyListeners();
  }
}
