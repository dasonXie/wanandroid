import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wanandroid/model/baseModel.dart';

import 'package:wanandroid/network/api.dart';
import 'package:wanandroid/network/networkManager.dart';

import 'package:flutter/material.dart';
import 'package:wanandroid/pages/system/model/systemModel.dart';
import 'package:wanandroid/pages/system/widget/systemGroup.dart';

class SystemPage extends StatefulWidget {
  SystemPage({Key key}) : super(key: key);

  @override
  _SystemPageState createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  BaseRespList<SystemModel> modelList;

  @override
  void initState() {
    super.initState();
    //加载数据
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return EasyRefresh(
      header: MaterialHeader(),
      onRefresh: () => loadData(),
      child: ListView.builder(
        itemCount: modelList == null ? 0 : modelList.data.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SystemGroup(modelList.data[index]),
              Divider(
                height: 0.1,
                color: Colors.grey[300],
              ),
            ],
          );
        },
      ),
    );
  }

  //加载网络数据
  loadData() async {
    final res = await NetworkManager.getInstance().request(
      WanAndroidApi.TREE + "/json",
      method: "get",
    );

    modelList =
        BaseRespList<SystemModel>(res, (res) => SystemModel.fromJson(res));

    //触发build
    setState(() {});
  }
}
