import 'package:wanandroid/model/baseModel.dart';
import 'package:wanandroid/model/demoModel.dart';
import 'package:wanandroid/network/api.dart';
import 'package:wanandroid/network/networkManager.dart';

import 'package:flutter/material.dart';

class SystemPage extends StatelessWidget {
  const SystemPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text("system_page"),
        onPressed: networkDemo,
      ),
    );
  }

  networkDemo() async {
    final res = await NetworkManager.getInstance().request(
      WanAndroidApi.BANNER + "/json",
      method: "get",
    );

    var modelList =
        BaseRespList<BannerModel>(res, (res) => BannerModel.fromJson(res));

    print(modelList);
    print(modelList.code);
    print(modelList.data.length);
    print(modelList.data[1]);
  }
}
