import 'package:json_annotation/json_annotation.dart';

part 'reposTreeModel.g.dart';

@JsonSerializable()
class ReposTreeModel {
  List<ReposTreeCellModel> data;

  ReposTreeModel(this.data);

  factory ReposTreeModel.fromJson(Map<String, dynamic> json) =>
      _$ReposTreeModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReposTreeModelToJson(this);
}

@JsonSerializable()
class ReposTreeCellModel {
  int id;
  String name;

  ReposTreeCellModel(this.id, this.name);

  factory ReposTreeCellModel.fromJson(Map<String, dynamic> json) =>
      _$ReposTreeCellModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReposTreeCellModelToJson(this);
}
