import 'package:school_todo_list/data/dto/task_dto.dart';

abstract class TaskRemoteSource {
  Future<List<TaskDto>> getTaskList();
  Future updateTaskList(List<TaskDto> list);
  Future<TaskDto> getTaskById(String id);
  Future<TaskDto> addTask(TaskDto task);
  Future<TaskDto> updateTask(TaskDto task);
  Future<TaskDto> deleteTaskById(String id);
}
