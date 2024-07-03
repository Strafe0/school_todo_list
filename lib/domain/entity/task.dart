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
  DateTime changedAt; //TODO: менять время
  bool done;

  bool get hasDeadline => deadline != null;

  void toggle() {
    done = !done;
  }
}
