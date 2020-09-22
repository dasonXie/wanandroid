import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wanandroid/model/baseModel.dart';
import 'package:wanandroid/network/api.dart';
import 'package:wanandroid/network/networkManager.dart';
import 'package:wanandroid/pages/repos/model/projectListModel.dart';
import 'package:wanandroid/pages/repos/model/projectModel.dart';
import 'package:wanandroid/pages/repos/widget/repos_list.dart';

class ReposPage extends StatefulWidget {
  ReposPage({Key key}) : super(key: key);

  @override
  _ReposPageState createState() => _ReposPageState();
}

class _ReposPageState extends State<ReposPage>
    with AutomaticKeepAliveClientMixin {
  BaseResp<ProjectModel> projectModel;
  List<ProjectListModel> projectList = new List<ProjectListModel>();
  EasyRefreshController _controller; //可以使用来触发刷新和加载
  int pageNum = 0;

  @override
  bool get wantKeepAlive => true; //避免initState方法重复调用

  @override
  void initState() {
    super.initState();
    //初始化数据
    getProjectList(true);
    _controller = EasyRefreshController();
  }

  Widget _getListData(context, index) {
    return ReposList(projectList[index]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        // footer: MaterialFooter(),
        onRefresh: () => getProjectList(true),
        onLoad: () => getProjectList(false),
        enableControlFinishLoad: true,
        controller: _controller,
        child: ListView.builder(
            itemCount: (projectList == null) ? 0 : projectList.length,
            itemBuilder: _getListData));
  }

  getProjectList(bool isRefresh) async {
    if (isRefresh) {
      this.pageNum = 0;
      projectList.clear();
      // _controller.resetLoadState();
    } else {
      this.pageNum++;
    }
    var res = await NetworkManager.getInstance().request(
      WanAndroidApi.ARTICLE_LISTPROJECT + "/${this.pageNum}/json",
      method: "get",
    );

    projectModel =
        BaseResp<ProjectModel>(res, (res) => ProjectModel.fromJson(res));

    projectList.addAll(projectModel.data.list);

    if (projectModel.data.list.length > 0) {
      _controller.finishLoad(success: true, noMore: false);
    } else {
      _controller.finishLoad(success: true, noMore: true);
    }

    // for (var i = 0; i < projectList.length; i++) {
    //   print("num:$i" + projectList[i].title);
    // }

    if (mounted) {
      setState(() {});
    }
  }
}
