import 'package:flutter/material.dart';
import 'package:wanandroid/pages/system/model/systemModel.dart';
import 'dart:math';

import 'package:wanandroid/pages/system/page/system_tab_page.dart';

class SystemItem extends StatelessWidget {
  final SystemModel model;

  //点击回调
  final void Function(String) callBack;

  const SystemItem(this.model, {Key key, this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: randomColor(),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Text(model.name),
      onPressed: () {
        callBack(model.name);
      },
    );
  }

  ///随机色
  randomColor() {
    return Color.fromRGBO(
        Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
  }
}
