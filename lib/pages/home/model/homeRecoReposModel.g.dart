// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeRecoReposModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeRecoReposModel _$HomeRecoReposModelFromJson(Map<String, dynamic> json) {
  return HomeRecoReposModel(
    json['curPage'] as int,
    (json['datas'] as List)
        ?.map((e) => e == null
            ? null
            : RecoReposCellModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HomeRecoReposModelToJson(HomeRecoReposModel instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'datas': instance.datas,
    };

RecoReposCellModel _$RecoReposCellModelFromJson(Map<String, dynamic> json) {
  return RecoReposCellModel(
    json['title'] as String,
    json['desc'] as String,
    json['envelopePic'] as String,
    json['link'] as String,
    json['author'] as String,
    json['niceDate'] as String,
    json['superChapterName'] as String,
  );
}

Map<String, dynamic> _$RecoReposCellModelToJson(RecoReposCellModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'desc': instance.desc,
      'envelopePic': instance.envelopePic,
      'link': instance.link,
      'author': instance.author,
      'niceDate': instance.niceDate,
      'superChapterName': instance.superChapterName,
    };
