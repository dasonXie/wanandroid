import 'package:json_annotation/json_annotation.dart';
part 'systemArticleModel.g.dart';

@JsonSerializable()
class ArticleListModel {
  int curPage;
  @JsonKey(name: "datas")
  List<ArticleModel> list;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  ArticleListModel(this.curPage, this.list, this.offset, this.over,
      this.pageCount, this.size, this.total);

  factory ArticleListModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleListModelToJson(this);
}

@JsonSerializable()
class ArticleModel {
  String niceDate;
  bool collect;
  String superChapterName;
  String shareUser;
  String title;
  int id;
  double publishTime;

  ArticleModel(this.niceDate, this.collect, this.superChapterName,
      this.shareUser, this.title, this.id);

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
