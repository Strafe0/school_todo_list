import 'dart:async';

import 'package:school_todo_list/domain/entity/task.dart';
import 'package:school_todo_list/domain/repository/task_repository.dart';

class TaskUseCase {
  TaskUseCase({
    required TaskRepository repository,
  }) : _repository = repository;

  final TaskRepository _repository;  

  Future<List<Task>> getAllTasks() async {
    final List<Task> taskList = await _repository.getTaskList();
    return taskList;
  }

  Future<bool> createTask(Task task) async {
    return await _repository.addTask(task);
  }

  Future<bool> deleteTask(String id) async {
    return await _repository.deleteTask(id);
  }

  Future<Task> getTask(String id) async {
    Task task = await _repository.getTask(id);
    return task;
  }

  Future<bool> updateTask(Task task) async {
    return await _repository.updateTask(task);
  }

  Future<bool> updateTaskList(List<Task> taskList) async {
    return await _repository.updateTaskList(taskList);
  }
}
