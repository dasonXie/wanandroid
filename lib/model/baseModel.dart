import 'dart:convert' show json;

import 'package:flutter/material.dart';

class BaseResp<T> {
  int code;
  String msg;
  T data;

  factory BaseResp(jsonStr, Function buildFun) => jsonStr is String
      ? BaseResp.fromJson(json.decode(jsonStr), buildFun)
      : BaseResp.fromJson(jsonStr, buildFun);

  BaseResp.fromJson(jsonRes, Function buildFun) {
    code = jsonRes['errorCode'];
    msg = jsonRes['errorMsg'];

    /// 这里可以做code和msg的处理逻辑
    data = buildFun(jsonRes['data']);
  }
}

class BaseRespList<T> extends ChangeNotifier {
  int code;
  String msg;
  List<T> data;

  factory BaseRespList(jsonStr, Function buildFun) => jsonStr is String
      ? BaseRespList._fromJson(json.decode(jsonStr), buildFun)
      : BaseRespList._fromJson(jsonStr, buildFun);

  BaseRespList._fromJson(jsonRes, Function buildFun) {
    code = jsonRes['errorCode'];
    msg = jsonRes['errorMsg'];

    data = (jsonRes['data'] as List).map<T>((ele) => buildFun(ele)).toList();
  }

  dataChange() {
    notifyListeners();
  }
}
