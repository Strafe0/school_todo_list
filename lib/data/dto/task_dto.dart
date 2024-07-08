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
  @JsonKey(name: "created_at")
  final int createdAt;
  @JsonKey(name: "changed_at")
  final int changedAt;
  @JsonKey(name: "last_updated_by")
  final String lastUpdatedBy;

  factory TaskDto.fromJson(Map<String, dynamic> json) =>
      _$TaskDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TaskDtoToJson(this);

  factory TaskDto.fromDbJson(Map<String, dynamic> dbJson) {
    Map<String, dynamic> json = Map.of(dbJson);

    if (json["done"] == 1) {
      json["done"] = true;
    } else {
      json["done"] = false;
    }

    return TaskDto.fromJson(json);
  }
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

  Map<String, dynamic> toApiJson() {
    return {"element": toJson()};
  }

  Map<String, dynamic> toDbJson() {
    Map<String, dynamic> json = toJson();
    json["done"] = done ? 1 : 0;
    return json;
  }
}
