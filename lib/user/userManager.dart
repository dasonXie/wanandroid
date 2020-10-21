import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid/config/config.dart';
import 'package:wanandroid/config/netWorkConfig.dart';
import 'package:wanandroid/model/baseModel.dart';
import 'package:wanandroid/network/api.dart';
import 'package:wanandroid/network/networkManager.dart';
import 'package:wanandroid/pages/login/model/userModel.dart';

class UserManager {
  static UserManager get instance => _getInstance();
  static UserManager _instance;

  UserModel model = UserModel();

  UserManager._internal();
  static UserManager _getInstance() {
    if (_instance == null) {
      _instance = new UserManager._internal();
      //初始化用户信息
      _instance._initUserInfo();
    }
    return _instance;
  }

  //初始化用户信息
  _initUserInfo() async {
    //获取本地存储的header
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String header = prefs.getString(NETWORK_HEADER);

    String username = prefs.getString(USERNAME);
    _instance._updateUserInfo(header, username: username);
  }

  ///更新用户数据
  _updateUserInfo(String header, {String username}) {
    if (header == null) {
      model.header = "";
    } else {
      model.header = header;
    }
    if (username != null) model.username = username;
  }

  ///用户是否登录
  bool isLogin() {
    return model.header.isNotEmpty;
  }

  _removeUserInfo() async {
    model = UserModel();

    //清除本地存储
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString("Cookie", "");
    await prefs.clear();
  }

//登录
  login(String username, String password, VoidCallback successCallback,
      VoidCallback failCallback) async {
    final params = {"username": username, "password": password};
    final res = await NetworkManager.getInstance()
        .loginRequest(WanAndroidApi.user_login, params: params);

    final model =
        BaseResp<UserModel>(res.data, (json) => UserModel.fromJson(json));

    if (model.code == 0) {
      //登陆成功，保存header
      res.headers.forEach((String name, List<String> values) async {
        if (name == "set-cookie") {
          String cookie = values.toString();
          //本地保存header
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString(NETWORK_HEADER, cookie);
          await prefs.setString(USERNAME, username);

          //更新header
          NetworkConfig.instance.headers["Cookie"] = cookie;
          UserManager.instance._updateUserInfo(cookie, username: username);
        }
      });

      if (successCallback != null) {
        successCallback();
      }
    } else {
      //登陆失败
      if (successCallback != null) {
        failCallback();
      }
    }
  }

//退出登录
  logout(VoidCallback successCallback, VoidCallback failCallback) {
    _removeUserInfo();
    NetworkConfig.instance.headers["Cookie"] = "";
    if (successCallback != null) {
      successCallback();
    }
  }
}
