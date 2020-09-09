// 1.import 导入json_annotation.dart
// import 'package:json_annotation/json_annotation.dart';

// // 2.user.g.dart 将在我们执行生成命令‘flutter packages pub run build_runner build’后json_serializable帮我们自动生成.g.dart文件，在未执行命令前该行可能会报错
// part 'homeModel.g.dart';

// // 3.这个标注是告诉生成器，这个类是需要生成Model类的
// @JsonSerializable()
// class User {
//   String name;
//   int age;
//   //显式关联JSON字段名与Model属性的对应关系,
//   // 如下将属性registerDate和register_date字段关联
//   @JsonKey(name: "register_date")
//   String registerDate;
//   List<String> courses;
//   // 4.必须的构造方法
//   User(this.name, this.age, this.registerDate, this.courses);
//   // 5.必须有的对应工厂构造器
//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
//   Map<String, dynamic> toJson() => _$UserToJson(this);
// }

import 'package:json_annotation/json_annotation.dart';
part 'demoModel.g.dart';

@JsonSerializable()
class BannerModel {
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  BannerModel(this.desc, this.id, this.imagePath, this.isVisible, this.order,
      this.title, this.type, this.url);

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
