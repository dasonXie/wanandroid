import 'package:json_annotation/json_annotation.dart';

part 'userModel.g.dart';

@JsonSerializable()
class UserModel {
  String email = "";
  String icon = "";
  int id = 0;
  String username = "";
  String password = "";

  ///请求头数据，使用的接口返回数据结构问题，所以这里直接保存header，其他信息暂时获取不了
  String header = "";

  // UserModel(this.email, this.icon, this.id, this.username, this.password,
  //     this.header);

  UserModel();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
