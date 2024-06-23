import 'package:school_todo_list/domain/entity/importance.dart';
import 'package:uuid/uuid.dart';

class Task {
  Task({
    required this.title,
    this.importance = Importance.none,
    this.deadline,
    this.done = false,
  }) : id = const Uuid().v1();

  String id;
  String title;
  Importance importance;
  DateTime? deadline;

  bool done;

  bool get hasDeadline => deadline != null;

  void toggle() {
    done = !done;
  }
}
