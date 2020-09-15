import 'package:json_annotation/json_annotation.dart';

part 'homeRecoReposModel.g.dart';

@JsonSerializable()
class HomeRecoReposModel {
  int curPage;
  List<RecoReposCellModel> datas;

  HomeRecoReposModel(this.curPage, this.datas);

  factory HomeRecoReposModel.fromJson(Map<String, dynamic> json) =>
      _$HomeRecoReposModelFromJson(json);
  Map<String, dynamic> toJson() => _$HomeRecoReposModelToJson(this);
}

@JsonSerializable()
class RecoReposCellModel {
  String title;
  String desc;
  String envelopePic;
  String link;
  String author;
  String niceDate;
  String superChapterName;

  RecoReposCellModel(this.title, this.desc, this.envelopePic, this.link,
      this.author, this.niceDate, this.superChapterName);

  factory RecoReposCellModel.fromJson(Map<String, dynamic> json) =>
      _$RecoReposCellModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecoReposCellModelToJson(this);
}
