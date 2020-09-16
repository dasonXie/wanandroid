import 'package:wanandroid/network/networkManager.dart';
import 'package:wanandroid/network/api.dart';

//首页banner data
Future getBanner() async {
  final res = await NetworkManager.getInstance().request(
    WanAndroidApi.BANNER + "/json",
    method: "get",
  );
  return res;
}

//项目列表 data
Future getReposList({int cid, int page}) async {
  int urlCid = cid == null ? 402 : cid;
  int urlPage = page == null ? 1 : page;
  final res = await NetworkManager.getInstance().request(
    WanAndroidApi.PROJECT_LIST + "/$urlPage/json?cid=$urlCid",
    method: "get",
  );
  return res;
}

//微信文章 data
Future getWXArticalList({int chapterId, int page}) async {
  int urlId = chapterId == null ? 408 : chapterId;
  int urlPage = page == null ? 1 : page;
  final res = await NetworkManager.getInstance().request(
    WanAndroidApi.WXARTICLE_LIST + "/$urlId/$urlPage/json",
    method: "get",
  );
  return res;
}

//获取分类数据
//type==1 ：项目分类
//type==2 ：微信工作号分类
Future getTreesList(int type) async {
  String url;
  if (type == 1) {
    //项目分类
    url = WanAndroidApi.PROJECT_TREE + "/json";
  } else {
    //微信工作号分类
    url = WanAndroidApi.WXARTICLE_CHAPTERS + "/json";
  }
  final res = await NetworkManager.getInstance().request(
    url,
    method: "get",
  );
  return res;
}
