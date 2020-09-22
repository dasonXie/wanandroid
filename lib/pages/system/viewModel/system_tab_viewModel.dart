import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wanandroid/model/baseModel.dart';
import 'package:wanandroid/network/api.dart';
import 'package:wanandroid/network/networkManager.dart';
import 'package:wanandroid/pages/system/model/systemArticleModel.dart';

class SystemTabViewModel extends ChangeNotifier {
  ArticleListModel modelList;
  int currentPage = 0;

  itemCount() {
    if (this.modelList == null || this.modelList.list == null) {
      return 0;
    } else {
      return this.modelList.list.length;
    }
  }

  //加载网络数据
  refreshData(String id, EasyRefreshController refreshController) async {
    final res = await NetworkManager.getInstance().request(
      WanAndroidApi.ARTICLE_LIST + "/0/json?cid=" + id,
      method: "get",
    );

    modelList =
        BaseResp<ArticleListModel>(res, (res) => ArticleListModel.fromJson(res))
            .data;

    currentPage = 0;
    refreshController.resetLoadState();
    notifyListeners();
  }

  //加载网络数据
  loadData(String id, EasyRefreshController refreshController) async {
    currentPage += 1;
    final res = await NetworkManager.getInstance().request(
      WanAndroidApi.ARTICLE_LIST + "/$currentPage/json?cid=" + id,
      method: "get",
    );

    var resultModel = BaseResp<ArticleListModel>(
        res, (res) => ArticleListModel.fromJson(res));

    modelList.list += resultModel.data.list;

    if (modelList.list.length >= resultModel.data.total) {
      refreshController.finishLoad(success: true, noMore: true);
    } else {
      refreshController.finishLoad(success: true, noMore: false);
    }
    notifyListeners();
  }
}
