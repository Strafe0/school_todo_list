// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDto _$TaskDtoFromJson(Map<String, dynamic> json) => TaskDto(
      id: json['id'] as String,
      text: json['text'] as String,
      importance: json['importance'] as String,
      deadline: (json['deadline'] as num?)?.toInt(),
      done: json['done'] as bool,
      color: json['color'] as String?,
      createdAt: (json['createdAt'] as num).toInt(),
      changedAt: (json['changedAt'] as num).toInt(),
      lastUpdatedBy: json['lastUpdatedBy'] as String,
    );

Map<String, dynamic> _$TaskDtoToJson(TaskDto instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'importance': instance.importance,
      'deadline': instance.deadline,
      'done': instance.done,
      'color': instance.color,
      'createdAt': instance.createdAt,
      'changedAt': instance.changedAt,
      'lastUpdatedBy': instance.lastUpdatedBy,
    };
