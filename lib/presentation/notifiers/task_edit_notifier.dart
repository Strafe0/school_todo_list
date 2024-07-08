import 'package:flutter/material.dart';
import 'package:school_todo_list/domain/entity/importance.dart';
import 'package:school_todo_list/domain/entity/task.dart';

class TaskEditNotifier extends ChangeNotifier {
  TaskEditNotifier({required this.task, required this.editMode});

  final Task task;
  final bool editMode;

  String get taskTitle => task.title;
  set taskTitle(String text) {
    task.title = text;
    notifyListeners();
  }

  Importance get taskImportance => task.importance;
  set importance(Importance importance) {
    task.importance = importance;
    notifyListeners();
  }

  DateTime? get taskDeadline => task.deadline;
  set deadline(DateTime? deadline) {
    task.deadline = deadline;
    notifyListeners();
  }
}
