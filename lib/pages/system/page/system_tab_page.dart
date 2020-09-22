import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/model/baseModel.dart';
import 'package:wanandroid/network/api.dart';
import 'package:wanandroid/network/networkManager.dart';
import 'package:wanandroid/pages/repos/page/web_page.dart';
import 'package:wanandroid/pages/system/model/systemArticleModel.dart';
import 'package:wanandroid/pages/system/viewModel/system_tab_viewModel.dart';
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

  EasyRefreshController refreshController = EasyRefreshController();
  // SystemTabViewModel viewModel = SystemTabViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // var prov = Provider.of<SystemTabViewModel>(context);
    // var notifi = Provider.of<SystemTabViewModel>(context);
    // notifi.refreshData(widget.cid, refreshController);
    return providerWidget(context);
  }

  providerWidget(BuildContext context) {
    // // 原有对象可以监听
    // return ChangeNotifierProvider<SystemTabViewModel>.value(
    //   value: viewModel,
    //   // builder: (context, child) => refreshWidget(context),
    //   child: Builder(
    //     builder: (context) => refreshWidget(context),
    //   ),
    // );

//没有对象可以监听
    return ChangeNotifierProvider<SystemTabViewModel>(
      create: (_) {
        var viewmodel = SystemTabViewModel();
        viewmodel.refreshData(widget.cid, refreshController);
        return viewmodel;
      },
      builder: (context, child) => refreshWidget2(context),
    );
  }

  // refreshWidget(BuildContext context) {
  //   return EasyRefresh(
  //     firstRefresh: false,
  //     onRefresh: () => viewModel.refreshData(widget.cid, refreshController),
  //     onLoad: () => viewModel.loadData(widget.cid, refreshController),
  //     enableControlFinishLoad: true,
  //     controller: refreshController,
  //     child: ListView.separated(
  //       itemCount: context.watch<SystemTabViewModel>().itemCount(),
  //       //添加分割线
  //       separatorBuilder: (BuildContext context, int index) {
  //         return Divider();
  //       },
  //       itemBuilder: (BuildContext context, int index) {
  //         return ArticleRow(
  //             context.watch<SystemTabViewModel>().modelList.list[index]);
  //       },
  //     ),
  //   );
  // }

  refreshWidget2(BuildContext context) {
    var notifi = Provider.of<SystemTabViewModel>(context);
    return EasyRefresh(
      firstRefresh: false,
      onRefresh: () => notifi.refreshData(widget.cid, refreshController),
      onLoad: () => notifi.loadData(widget.cid, refreshController),
      enableControlFinishLoad: true,
      controller: refreshController,
      child: ListView.separated(
        itemCount: notifi.itemCount(),
        //添加分割线
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: ArticleRow(notifi.modelList.list[index]),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return WebPage(
                    notifi.modelList.list[index].link,
                    title: notifi.modelList.list[index].title,
                  );
                },
              ));
            },
          );
        },
      ),
    );
  }
}
