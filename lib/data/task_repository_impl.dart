import 'package:school_todo_list/data/dto/task_dto.dart';
import 'package:school_todo_list/data/source/local/task_local_source.dart';
import 'package:school_todo_list/data/source/remote/task_remote_source.dart';
import 'package:school_todo_list/domain/entity/task.dart';
import 'package:school_todo_list/domain/repository/task_repository.dart';
import 'package:school_todo_list/logger.dart';

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl({
    required TaskRemoteSource remoteSource,
    required TaskDatabase database,
  })  : _remoteSource = remoteSource,
        _db = database;

  final TaskRemoteSource _remoteSource;
  final TaskDatabase _db;

  @override
  Future<bool> addTask(Task task) async {
    logger.d("Repo: addTask");
    try {
      TaskDto taskDto = await _remoteSource.addTask(task.toTaskDto());
      await _db.addCachedTask(taskDto);
      return true;
    } catch (error, stackTrace) {
      logger.e("Failed to add task", error: error, stackTrace: stackTrace);
      return false;
    }
  }

  @override
  Future<bool> deleteTask(String id) async {
    logger.d("Repo: deleteTask");
    try {
      await _remoteSource.deleteTaskById(id);
      await _db.deleteCachedTaskById(id);
      return true;
    } catch (error, stackTrace) {
      logger.e(
        "Failed to delete task",
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<Task> getTask(String id) async {
    logger.d("Repo: getTask");
    try {
      TaskDto taskDto = await _remoteSource.getTaskById(id);
      await _db.updateCachedTask(taskDto);

      return taskDto.toTask();
    } catch (error, stackTrace) {
      logger.e(
        "Failed to get task",
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<List<Task>> getTaskList() async {
    logger.d("Repo: getTaskList");
    try {
      List<TaskDto> taskList = await _remoteSource.getTaskList();
      await _db.saveTaskList(taskList);
      List<TaskDto> cachedTasks = await _db.getCachedTaskList();
      return cachedTasks.map((t) => t.toTask()).toList();
    } catch (error, stackTrace) {
      logger.e(
        "Failed to receive task list",
        error: error,
        stackTrace: stackTrace,
      );
      throw Exception("Error receiving task list");
    }
  }

  @override
  Future<bool> updateTask(Task updatedTask) async {
    logger.d("Repo: updateTask");
    try {
      TaskDto taskDto = await _remoteSource.updateTask(updatedTask.toTaskDto());
      await _db.updateCachedTask(taskDto);
      return true;
    } catch (error, stackTrace) {
      logger.e(
        "Failed to update task list",
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<bool> updateTaskList(List<Task> list) async {
    logger.d("Repo: updateTaskList");
    try {
      List<TaskDto> taskDtos = await _remoteSource.updateTaskList(
        list.map((t) => t.toTaskDto()).toList()
      );
      await _db.saveTaskList(taskDtos);
      return true;
    } catch (error, stackTrace) {
      logger.e(
        "Failed to update task list",
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

}