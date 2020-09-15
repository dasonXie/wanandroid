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
Future getReposList() async {
  final res = await NetworkManager.getInstance().request(
    WanAndroidApi.PROJECT_LIST + "/1/json?cid=402",
    method: "get",
  );
  return res;
}

//微信文章 data
Future getWXArticalList() async {
  final res = await NetworkManager.getInstance().request(
    WanAndroidApi.WXARTICLE_LIST + "/408/1/json",
    method: "get",
  );
  return res;
}
