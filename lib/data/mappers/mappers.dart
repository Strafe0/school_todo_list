import 'package:school_todo_list/data/dto/task_dto.dart';
import 'package:school_todo_list/domain/entity/importance.dart';
import 'package:school_todo_list/domain/entity/task.dart';

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
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        Duration(
          seconds: createdAt,
        ).inMilliseconds,
      ),
      changedAt: DateTime.fromMillisecondsSinceEpoch(
        Duration(
          seconds: changedAt,
        ).inMilliseconds,
      ),
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

extension TaskExtension on Task {
  TaskDto toTaskDto() {
    return TaskDto(
      id: id,
      text: title,
      importance: switch (importance) {
        Importance.none => "basic",
        Importance.low => "low",
        Importance.high => "important",
      },
      deadline: hasDeadline
          ? Duration(milliseconds: deadline!.millisecondsSinceEpoch).inSeconds
          : null,
      done: done,
      createdAt: Duration(
        milliseconds: createdAt.millisecondsSinceEpoch,
      ).inSeconds,
      changedAt: Duration(
        milliseconds: changedAt.millisecondsSinceEpoch,
      ).inSeconds,
      lastUpdatedBy: "123", //TODO: add device id
    );
  }

  Task copyWith({
    String? title,
    bool? done,
    Importance? importance,
    DateTime? deadline,
    DateTime? createdAt,
    DateTime? changedAt,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      done: done ?? this.done,
      importance: importance ?? this.importance,
      deadline: deadline ?? this.deadline,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
    );
  }
}

class TaskListMapper {
  static List<Task> toTaskList(List<TaskDto> tasks) =>
      tasks.map((t) => t.toTask()).toList();

  static List<TaskDto> toTaskDtoList(List<Task> tasks) =>
      tasks.map((t) => t.toTaskDto()).toList();

  static List<TaskDto> toTaskDtoListWithTimeUpdate(List<Task> tasks) {
    DateTime now = DateTime.now();

    return tasks.map((t) => (t..changedAt = now).toTaskDto()).toList();
  }
}