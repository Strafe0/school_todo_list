// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListResponse _$ListResponseFromJson(Map<String, dynamic> json) => ListResponse(
      json['status'] as String,
      (json['revision'] as num).toInt(),
      (json['list'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$ListResponseToJson(ListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'revision': instance.revision,
      'list': instance.list,
    };

ElementResponse _$ElementResponseFromJson(Map<String, dynamic> json) =>
    ElementResponse(
      json['status'] as String,
      (json['revision'] as num).toInt(),
      json['element'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ElementResponseToJson(ElementResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'revision': instance.revision,
      'element': instance.element,
    };
