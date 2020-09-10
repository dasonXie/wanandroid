// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'systemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemModel _$SystemModelFromJson(Map<String, dynamic> json) {
  return SystemModel(
    (json['children'] as List)
        ?.map((e) =>
            e == null ? null : SystemModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['courseId'] as int,
    json['id'] as int,
    json['name'] as String,
    json['order'] as int,
    json['parentChapterId'] as int,
    json['userControlSetTop'] as bool,
    json['visible'] as int,
  );
}

Map<String, dynamic> _$SystemModelToJson(SystemModel instance) =>
    <String, dynamic>{
      'children': instance.children,
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'userControlSetTop': instance.userControlSetTop,
      'visible': instance.visible,
    };
