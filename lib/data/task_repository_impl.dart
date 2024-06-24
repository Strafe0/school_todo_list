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
  Future<void> addTask(Task task) async {
    logger.i("Repo: addTask");
    TaskDto taskDto = await _remoteSource.addTask(task.toTaskDto());
    TaskDto cachedTask = await _db.addCachedTask(taskDto);
  }

  @override
  Future<void> deleteTask(String id) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<Task> getTask(String id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getTaskList() {
    // TODO: implement getTaskList
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(Task updatedTask) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }

  @override
  Future<void> updateTaskList(List<Task> list) {
    // TODO: implement updateTaskList
    throw UnimplementedError();
  }

}