import 'package:school_todo_list/domain/entity/importance.dart';
import 'package:uuid/uuid.dart';

class Task {
  Task({
    required this.title,
    this.importance = Importance.none,
    this.deadline,
  }) : id = const Uuid().v1(), _isCompleted = false;

  String id;
  String title;
  Importance importance;
  DateTime? deadline;

  bool _isCompleted;
  bool get isCompleted => _isCompleted;

  void toggle() {
    _isCompleted = !_isCompleted;
  }
}