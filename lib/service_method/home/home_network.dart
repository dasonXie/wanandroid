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
Future getReposList({int cid}) async {
  final res = await NetworkManager.getInstance().request(
    WanAndroidApi.PROJECT_LIST +
        (cid == null ? "/1/json?cid=402" : "/1/json?cid=${cid}"),
    method: "get",
  );
  return res;
}

//微信文章 data
Future getWXArticalList({int chapterId}) async {
  final res = await NetworkManager.getInstance().request(
    WanAndroidApi.WXARTICLE_LIST +
        (chapterId == null ? "/408/1/json" : "/${chapterId}/1/json"),
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
