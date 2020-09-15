import 'package:json_annotation/json_annotation.dart';
part 'projectListModel.g.dart';

@JsonSerializable()
class ProjectListModel {
  int id;
  String title;
  String desc;
  String author;
  String link;
  String projectLink;
  String envelopePic;
  String superChapterName;
  int publishTime;
  bool collect;

  ProjectListModel(
      this.id,
      this.title,
      this.desc,
      this.author,
      this.link,
      this.projectLink,
      this.envelopePic,
      this.superChapterName,
      this.publishTime,
      this.collect);

  factory ProjectListModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectListModelFromJson(json);

  Map<String,dynamic> toJson() => _$ProjectListModelToJson(this);
}
