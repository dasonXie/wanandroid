// http://www.wanandroid.com/article/list/0/json?cid=60
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wanandroid/model/baseModel.dart';
import 'package:wanandroid/network/api.dart';
import 'package:wanandroid/network/networkManager.dart';
import 'package:wanandroid/pages/system/model/systemArticleModel.dart';
import 'package:wanandroid/pages/system/widget/articleRow.dart';

class SystemTabPage extends StatefulWidget {
  final String cid;
  SystemTabPage(this.cid, {Key key}) : super(key: key);

  @override
  _SystemTabPageState createState() => _SystemTabPageState();
}

class _SystemTabPageState extends State<SystemTabPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ArticleListModel _modelList;
  int currentPage = 0;
  RefreshBLoC bloc = RefreshBLoC();
  EasyRefreshController refreshController = EasyRefreshController();

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return streamWidget();
  }

  streamWidget() {
    return StreamBuilder(
      stream: bloc.steream,
      initialData: 0,
      builder: (context, snapshot) {
        return refreshWidget();
      },
    );
  }

  refreshWidget() {
    return EasyRefresh(
      firstRefresh: false,
      onRefresh: () => refreshData(),
      onLoad: () => loadData(),
      enableControlFinishLoad: true,
      controller: refreshController,
      child: ListView.separated(
        itemCount: this._modelList == null ? 0 : this._modelList.list.length,
        //添加分割线
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          print(_modelList.list[index].title);
          return ArticleRow(_modelList.list[index]);
        },
      ),
    );
  }

  //加载网络数据
  refreshData() async {
    final res = await NetworkManager.getInstance().request(
      WanAndroidApi.ARTICLE_LIST + "/0/json?cid=" + widget.cid,
      method: "get",
    );

    _modelList =
        BaseResp<ArticleListModel>(res, (res) => ArticleListModel.fromJson(res))
            .data;

    currentPage = 0;
    refreshController.resetLoadState();
    //bloc状态管理
    bloc.refresh();
  }

  //加载网络数据
  loadData() async {
    currentPage += 1;
    final res = await NetworkManager.getInstance().request(
      WanAndroidApi.ARTICLE_LIST + "/$currentPage/json?cid=" + widget.cid,
      method: "get",
    );

    var resultModel = BaseResp<ArticleListModel>(
        res, (res) => ArticleListModel.fromJson(res));

    _modelList.list += resultModel.data.list;

    if (_modelList.list.length >= resultModel.data.total) {
      refreshController.finishLoad(success: true, noMore: true);
    } else {
      refreshController.finishLoad(success: true, noMore: false);
    }

    //bloc状态管理
    bloc.refresh();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}

//BLoC通道流
class RefreshBLoC {
  var _controllerStream = StreamController<int>();

  Stream<int> get steream => _controllerStream.stream;

  refresh() {
    _controllerStream.sink.add(1);
  }

  dispose() {
    _controllerStream.close();
  }
}
