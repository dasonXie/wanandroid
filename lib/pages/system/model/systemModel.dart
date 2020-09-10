import 'package:json_annotation/json_annotation.dart';
part 'systemModel.g.dart';

@JsonSerializable()
class SystemModel {
  List<SystemModel> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  SystemModel(this.children, this.courseId, this.id, this.name, this.order,
      this.parentChapterId, this.userControlSetTop, this.visible);

  factory SystemModel.fromJson(Map<String, dynamic> json) =>
      _$SystemModelFromJson(json);
  Map<String, dynamic> toJson() => _$SystemModelToJson(this);
}
