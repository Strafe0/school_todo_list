import 'package:school_todo_list/data/dto/task_dto.dart';
import 'package:school_todo_list/data/source/local/database.dart';

abstract class TaskDatabase {
  Future<List<TaskDto>> getCachedTaskList();
  Future<void> saveTaskList(List<TaskDto> list);
  Future<TaskDto> getCachedTaskById(String id);
  Future<void> addCachedTask(TaskDto task);
  Future<void> updateCachedTask(TaskDto task);
  Future<void> deleteCachedTaskById(String id);
}

class TaskDatabaseImpl implements TaskDatabase {
  TaskDatabaseImpl(this._db);

  AppDatabase _db;

  @override
  Future<TaskDto> addCachedTask(TaskDto task) {
    // TODO: implement addCachedTask
    throw UnimplementedError();
  }

  @override
  Future<TaskDto> deleteCachedTaskById(String id) {
    // TODO: implement deleteCachedTaskById
    throw UnimplementedError();
  }

  @override
  Future<TaskDto> getCachedTaskById(String id) {
    // TODO: implement getCachedTaskById
    throw UnimplementedError();
  }

  @override
  Future<List<TaskDto>> getCachedTaskList() async {
    List<TaskDto> tasks = await _db.getAll();

    return tasks;
  }

  @override
  Future<void> saveTaskList(List<TaskDto> list) async {
    await _db.saveTaskList(list);
  }

  @override
  Future<void> updateCachedTask(TaskDto task) async {
    await _db.updateTask(task);
  }
}