import 'package:school_todo_list/data/dto/task_dto.dart';

abstract class TaskDatabase {
  Future<List<TaskDto>> getCachedTaskList();
  Future<bool> saveTaskList(List<TaskDto> list);
  Future<TaskDto> getCachedTaskById(String id);
  Future<TaskDto> addCachedTask(TaskDto task);
  Future<TaskDto> updateCachedTask(TaskDto task);
  Future<TaskDto> deleteCachedTaskById(String id);
}
