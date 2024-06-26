import 'package:school_todo_list/data/dto/task_dto.dart';
import 'package:school_todo_list/data/source/remote/api/response/response.dart';
import 'package:school_todo_list/data/source/remote/api/services/task_service.dart';
import 'package:school_todo_list/logger.dart';

abstract class TaskRemoteSource {
  Future<List<TaskDto>> getTaskList();
  Future<List<TaskDto>> updateTaskList(List<TaskDto> list);
  Future<TaskDto> getTaskById(String id);
  Future<TaskDto> addTask(TaskDto task);
  Future<TaskDto> updateTask(TaskDto task);
  Future<TaskDto> deleteTaskById(String id);
}

class TaskRemoteSourceImpl implements TaskRemoteSource {
  TaskRemoteSourceImpl(this._taskService);

  final TaskService _taskService;

  @override
  Future<TaskDto> addTask(TaskDto task) async {
    try {
      ElementResponse response = await _taskService.createTask(task);
      return TaskDto.fromJson(response.element);
    } catch (error, stackTrace) {
      logger.e(
        "TaskRemoteSource: failed to create task!",
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<TaskDto> deleteTaskById(String id) async {
    try {
      ElementResponse response = await _taskService.deleteTask(id);
      return TaskDto.fromJson(response.element);
    } catch (error, stackTrace) {
      logger.e(
        "TaskRemoteSource: failed to delete task!",
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<TaskDto> getTaskById(String id) async {
    try {
      ElementResponse response = await _taskService.getById(id);
      return TaskDto.fromJson(response.element);
    } catch (error, stackTrace) {
      logger.e(
        "TaskRemoteSource: failed to get task!",
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<List<TaskDto>> getTaskList() async {
    try {
      ListResponse response = await _taskService.getAll();
      List<TaskDto> taskDtos = response.list.map(
        (m) => TaskDto.fromJson(m),
      ).toList();
      return taskDtos;
    } catch (error, stackTrace) {
      logger.e(
        "TaskRemoteSource: failed to get list of tasks",
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<TaskDto> updateTask(TaskDto task) async {
    try {
      ElementResponse response = await _taskService.updateTask(task.id, task);
      return TaskDto.fromJson(response.element);
    } catch (error, stackTrace) {
      logger.e(
        "TaskRemoteSource: failed to update task!",
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<List<TaskDto>> updateTaskList(List<TaskDto> list) async {
    try {
      ListResponse response = await _taskService.updateAll(list);
      List<TaskDto> taskDtos = response.list.map(
        (m) => TaskDto.fromJson(m),
      ).toList();
      return taskDtos;
    } catch (error, stackTrace) {
      logger.e(
        "TaskRemoteSource: failed to update task list!",
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
