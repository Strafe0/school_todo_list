import 'package:school_todo_list/domain/entity/task.dart';
import 'package:school_todo_list/domain/repository/task_repository.dart';

class TaskUseCase {
  TaskUseCase({required TaskRepository repository}) : _repository = repository;

  final TaskRepository _repository;

  Future<List<Task>> getAllTasks() async {
    final List<Task> taskList = await _repository.getTaskList();
    return taskList;
  }

  Future<void> createTask(Task task) async {
    await _repository.addTask(task);
  }

  Future<void> deleteTask(String id) async {
    await _repository.deleteTask(id);
  }

  Future<Task> getTask(String id) async {
    Task task = await _repository.getTask(id);
    return task;
  }

  Future<void> updateTask(Task task) async {
    await _repository.updateTask(task);
  }

  Future<void> updateTaskList(List<Task> taskList) async {
    await _repository.updateTaskList(taskList);
  }
}