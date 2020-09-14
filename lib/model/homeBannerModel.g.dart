// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeBannerModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBannerModel _$HomeBannerModelFromJson(Map<String, dynamic> json) {
  return HomeBannerModel(
    json['imagePath'] as String,
    json['title'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$HomeBannerModelToJson(HomeBannerModel instance) =>
    <String, dynamic>{
      'imagePath': instance.imagePath,
      'title': instance.title,
      'url': instance.url,
    };
