import 'package:json_annotation/json_annotation.dart';
import 'package:school_todo_list/domain/entity/importance.dart';
import 'package:school_todo_list/domain/entity/task.dart';

part 'task_dto.g.dart';

@JsonSerializable()
class TaskDto {
  TaskDto({
    required this.id,
    required this.text,
    required this.importance,
    this.deadline,
    required this.done,
    this.color,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
  });

  final String id;
  final String text;
  final String importance;
  final int? deadline;
  final bool done;
  final String? color;
  final int createdAt;
  final int changedAt;
  final String lastUpdatedBy;

  factory TaskDto.fromJson(Map<String, dynamic> json) => _$TaskDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TaskDtoToJson(this);
}

extension TaskDtoMapper on TaskDto {
  Task toTask() {
    return Task(
      id: id,
      title: text,
      importance: switch (importance) {
        "low" => Importance.low,
        "important" => Importance.high,
        _ => Importance.none,
      },
      done: done,
      deadline: deadline != null
          ? DateTime.fromMillisecondsSinceEpoch(
              Duration(seconds: deadline!).inMilliseconds,
            )
          : null,
    );
  }
}