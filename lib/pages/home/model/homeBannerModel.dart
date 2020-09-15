import 'package:json_annotation/json_annotation.dart';

part 'homeBannerModel.g.dart';

@JsonSerializable()
class HomeBannerModel {
  String imagePath;
  String title;
  String url;

  HomeBannerModel(this.imagePath, this.title, this.url);

  factory HomeBannerModel.fromJson(Map<String, dynamic> json) =>
      _$HomeBannerModelFromJson(json);
  Map<String, dynamic> toJson() => _$HomeBannerModelToJson(this);
}
