import 'dart:async';

import 'package:school_todo_list/data/dto/task_dto.dart';
import 'package:school_todo_list/data/mappers/mappers.dart';
import 'package:school_todo_list/data/source/local/task_local_source.dart';
import 'package:school_todo_list/data/source/remote/connectivity.dart';
import 'package:school_todo_list/data/source/remote/task_remote_source.dart';
import 'package:school_todo_list/domain/entity/task.dart';
import 'package:school_todo_list/domain/repository/task_repository.dart';
import 'package:school_todo_list/logger.dart';

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl({
    required TaskRemoteSource remoteSource,
    required TaskDatabase database,
    required ConnectionChecker connectionChecker,
  })  : _remoteSource = remoteSource,
        _db = database,
        _connectionChecker = connectionChecker;

  final TaskRemoteSource _remoteSource;
  final TaskDatabase _db;
  final ConnectionChecker _connectionChecker;

  Future<bool> get hasConnection async => _connectionChecker.hasConnection(); 

  @override
  Future<bool> addTask(Task task) async {
    try {
      if (await hasConnection) {
        logger.d("Repo: addTask (online)");
        TaskDto taskDto = await _remoteSource.addTask(task.toTaskDto());
        await _db.addCachedTask(taskDto);
      } else {
        logger.d("Repo: addTask (offline)");
        await _db.addCachedTask(task.toTaskDto());
      }
      
      return true;
    } catch (error, stackTrace) {
      logger.e("Failed to add task", error: error, stackTrace: stackTrace);
      return false;
    }
  }

  @override
  Future<bool> deleteTask(String id) async {
    try {
      if (await hasConnection) {
        logger.d("Repo: deleteTask on server");
        await _remoteSource.deleteTaskById(id);
      }
      logger.d("Repo: delete task on device");
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
    try {
      if (await hasConnection) {
        logger.d("Repo: getTask (online)");
        TaskDto taskDto = await _remoteSource.getTaskById(id);
        await _db.updateCachedTask(taskDto);

        return taskDto.toTask();
      } else {
        logger.d("Repo: getTask (offline)");
        return (await _db.getCachedTaskById(id)).toTask();
      }
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
    try {
      if (await hasConnection) {
        logger.d("Repo: getTaskList (online)");
        List<TaskDto> taskList = await _remoteSource.getTaskList();
        await _db.saveTaskList(taskList);

        List<TaskDto> cachedTasks = await _db.getCachedTaskList();
        return cachedTasks.map((t) => t.toTask()).toList();
      } else {
        logger.d("Repo: getTaskList (offline)");
        return (await _db.getCachedTaskList()).map((t) => t.toTask()).toList();
      }
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
    try {
      updatedTask.changedAt = DateTime.now();
      if (await hasConnection) {
        logger.d("Repo: updateTask (online)");
        TaskDto taskDto = await _remoteSource.updateTask(updatedTask.toTaskDto());
        await _db.updateCachedTask(taskDto);
      } else {
        logger.d("Repo: updateTask (offline)");
        await _db.updateCachedTask(updatedTask.toTaskDto());
      }
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
    try {
      List<TaskDto> taskDtos = TaskListMapper.toTaskDtoListWithTimeUpdate(list);
      
      if (await hasConnection) {
        logger.d("Repo: updateTaskList");
        List<TaskDto> remoteTasks =
            await _remoteSource.updateTaskList(taskDtos);
        await _db.saveTaskList(remoteTasks);
      } else {
        logger.d("Repo: updateTaskList (offline)");
        await _db.saveTaskList(taskDtos);
      }
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
  Future<bool> updateOutdatedData() async {
    logger.d("Repo: updateOutdatedData");
    try {
      List<TaskDto> outdatedTasks = await _db.getCachedTaskList();
      logger.d("Tasks for update : ${outdatedTasks.length}");

      if (outdatedTasks.isNotEmpty) {
        _updateRevision();
        List<TaskDto> updatedTasks = await _remoteSource.updateTaskList(
          outdatedTasks,
        );
        logger.d("Updated tasks: ${updatedTasks.length}");
  
        await _db.clearDatabase();
        await _db.saveTaskList(updatedTasks);
      }

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

  Future<void> _updateRevision() async {
    await _remoteSource.getTaskList();
  }
}
