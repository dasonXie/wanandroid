import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid/pages/repos/model/projectListModel.dart';
part 'projectModel.g.dart';

@JsonSerializable()
class ProjectModel {
  int curPage;
  bool over;
  @JsonKey(name: "datas")
  List<ProjectListModel> list;

  ProjectModel(this.curPage, this.over, this.list);

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);
}
