import 'package:flutter/material.dart';
import 'package:school_todo_list/domain/entity/task.dart';
import 'package:school_todo_list/domain/usecase/task_usecase.dart';
import 'package:school_todo_list/logger.dart';

class TaskListNotifier extends ChangeNotifier {
  TaskListNotifier(this._taskUseCase);

  final TaskUseCase _taskUseCase;

  List<Task> _tasks = [];
  bool _showCompleted = false;
  bool _isLoading = false;

  bool get showCompleted => _showCompleted;
  set showCompleted(bool use) {
    _showCompleted = use;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  int get completedTasksCount {
    int count = 0;
    for (var task in _tasks) {
      if (task.done) {
        count++;
      }
    }
    return count;
  }

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tasks = await _taskUseCase.getAllTasks();
    } catch (error, stackTrace) {
      logger.e(
        "TaskListNotifier: error load tasks",
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Task> get filteredTasks => _tasks.where((task) {
    if (_showCompleted) {
      return true;
    } else {
      return !task.done;
    }
  }).toList();

  Future<bool> createTask(Task task) async {
    bool result = await _taskUseCase.createTask(task);
    if (result) {
      await loadTasks();
    }

    notifyListeners();
    return result;
  }

  Future<bool> updateTask(Task task) async {
    bool result = await _taskUseCase.updateTask(task);
    if (result) {
      await loadTasks();
    }

    notifyListeners();
    return result;
  }

  Future<bool> deleteTask(String id) async {
    bool result = await _taskUseCase.deleteTask(id);
    if (result) {
      _tasks.removeWhere((t) => t.id == id);
    }

    notifyListeners();
    return result;
  }
}