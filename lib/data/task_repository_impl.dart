import 'dart:async';
import 'package:school_todo_list/data/dto/task_dto.dart';
import 'package:school_todo_list/data/mappers/mappers.dart';
import 'package:school_todo_list/data/source/local/task_local_source.dart';
import 'package:school_todo_list/data/source/remote/api/revision_holder.dart';
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
    required RevisionHolder revisionHolder,
  })  : _remoteSource = remoteSource,
        _db = database,
        _connectionChecker = connectionChecker,
        _revisionHolder = revisionHolder;

  final TaskRemoteSource _remoteSource;
  final TaskDatabase _db;
  final ConnectionChecker _connectionChecker;
  final RevisionHolder _revisionHolder;

  Future<bool> get hasConnection async => _connectionChecker.hasConnection();

  @override
  Future<bool> addTask(Task task) async {
    try {
      if (await hasConnection) {
        logger.d("Repo: addTask (online)");
        TaskDto taskDto = await _remoteSource.addTask(task.toTaskDto());
        await _db.addCachedTask(taskDto);
        await _revisionHolder.saveLocalRevision(_revisionHolder.remoteRevision);
      } else {
        logger.d("Repo: addTask (offline)");
        await _db.addCachedTask(task.toTaskDto());
        await _revisionHolder.increaseLocalRevision();
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
        logger.d("Repo: deleteTask (online)");
        await _remoteSource.deleteTaskById(id);
        await _db.deleteCachedTaskById(id);
        await _revisionHolder.saveLocalRevision(_revisionHolder.remoteRevision);
      } else {
        logger.d("Repo: deleteTask (offline)");
        await _db.deleteCachedTaskById(id);
        await _revisionHolder.increaseLocalRevision();
      }

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
        List<TaskDto> remoteTaskList = await _remoteSource.getTaskList();
        List<TaskDto> localTaskList = await _db.getCachedTaskList();

        await _synchronize(remoteTaskList, localTaskList);

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
        TaskDto taskDto = await _remoteSource.updateTask(
          updatedTask.toTaskDto(),
        );
        await _db.updateCachedTask(taskDto);
        await _revisionHolder.saveLocalRevision(_revisionHolder.remoteRevision);
      } else {
        logger.d("Repo: updateTask (offline)");
        await _db.updateCachedTask(updatedTask.toTaskDto());
        await _revisionHolder.increaseLocalRevision();
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
        await _revisionHolder.saveLocalRevision(_revisionHolder.remoteRevision);
      } else {
        logger.d("Repo: updateTaskList (offline)");
        await _db.saveTaskList(taskDtos);
        await _revisionHolder.increaseLocalRevision();
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
      List<TaskDto> remoteTasks = await _remoteSource.getTaskList();
      List<TaskDto> localTasks = await _db.getCachedTaskList();

      await _synchronize(remoteTasks, localTasks);

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

  Future<void> _synchronize(
    List<TaskDto> remoteTasks,
    List<TaskDto> localTasks,
  ) async {
    Set<TaskDto> remoteTasksSet = remoteTasks.toSet();
    Set<TaskDto> localTasksSet = localTasks.toSet();

    List<Future> tasksForLocalAdding = [];
    List<Future> tasksForLocalUpdating = [];
    List<Future> tasksForLocalRemoving = [];
    List<Future> tasksForRemoteAdding = [];
    List<Future> tasksForRemoteUpdating = [];
    List<Future> tasksForRemoteRemoving = [];

    if (_revisionHolder.remoteRevision > _revisionHolder.localRevision) {
      for (var remoteTask in remoteTasksSet) {
        TaskDto? localTask = localTasksSet.lookup(remoteTask);
        if (localTask == null) {
          // ok
          // На сервере задача есть, локально - нету
          tasksForLocalAdding.add(_db.addCachedTask(remoteTask));
        } else if (localTask.changedAt < remoteTask.changedAt) {
          // ok
          // На сервере задача новее
          tasksForLocalUpdating.add(_db.updateCachedTask(remoteTask));
        } else if (localTask.changedAt != remoteTask.changedAt) {
          // На сервере задача старее
          tasksForRemoteUpdating.add(_remoteSource.updateTask(localTask));
        }
      }

      // Задачи, которые есть локально, но нет на сервере
      Set<TaskDto> diff = localTasksSet.difference(remoteTasksSet); // ok
      tasksForLocalRemoving
          .addAll(diff.map((t) => _db.deleteCachedTaskById(t.id)));
    } else {
      for (var localTask in localTasksSet) {
        TaskDto? remoteTask = remoteTasksSet.lookup(localTask);
        if (remoteTask == null) {
          // ok
          // На устройстве задача есть, на сервере нету
          tasksForRemoteAdding.add(_remoteSource.addTask(localTask));
        } else if (remoteTask.changedAt < localTask.changedAt) {
          // ok
          // На устройстве задача новее
          tasksForRemoteUpdating.add(_remoteSource.updateTask(localTask));
        } else if (remoteTask.changedAt != localTask.changedAt) {
          // На устройстве задача старее
          tasksForLocalUpdating.add(_db.updateCachedTask(remoteTask));
        }
      }

      Set<TaskDto> diff = remoteTasksSet.difference(localTasksSet); // ok
      tasksForRemoteRemoving
          .addAll(diff.map((t) => _remoteSource.deleteTaskById(t.id)));
    }

    _revisionHolder.saveLocalRevision(_revisionHolder.remoteRevision);

    logger.i("Tasks for local adding: ${tasksForLocalAdding.length}");
    logger.i("Tasks for local updating: ${tasksForLocalUpdating.length}");
    logger.i("Tasks for local removing: ${tasksForLocalRemoving.length}");
    logger.i("Tasks for remote adding: ${tasksForRemoteAdding.length}");
    logger.i("Tasks for remote updating: ${tasksForRemoteUpdating.length}");
    logger.i("Tasks for remote removing: ${tasksForRemoteRemoving.length}");

    await Future.wait(tasksForLocalAdding);
    await Future.wait(tasksForLocalUpdating);
    await Future.wait(tasksForLocalRemoving);

    await Future.wait(tasksForRemoteAdding);
    await Future.wait(tasksForRemoteUpdating);
    await Future.wait(tasksForRemoteRemoving);
  }
}
