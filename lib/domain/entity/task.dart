import 'package:school_todo_list/data/dto/task_dto.dart';
import 'package:school_todo_list/domain/entity/importance.dart';
import 'package:uuid/uuid.dart';

class Task {
  Task({
    String? id,
    required this.title,
    this.importance = Importance.none,
    this.deadline,
    this.done = false,
    DateTime? createdAt,
    DateTime? changedAt,
  })  : id = id ?? const Uuid().v1(),
        createdAt = createdAt ?? DateTime.now(),
        changedAt = changedAt ?? DateTime.now();

  String id;
  String title;
  Importance importance;
  DateTime? deadline;
  DateTime createdAt;
  DateTime changedAt;

  bool done;

  bool get hasDeadline => deadline != null;

  void toggle() {
    done = !done;
  }
}

extension Mapper on Task {
  TaskDto toTaskDto() {
    return TaskDto(
      id: id,
      text: title,
      importance: switch (importance) {
        Importance.none => "basic",
        Importance.low => "low",
        Importance.high => "high",
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
      lastUpdatedBy: "123" //TODO: add device id
    );
  }
}