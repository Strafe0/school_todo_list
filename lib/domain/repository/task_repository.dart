import 'package:school_todo_list/domain/entity/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTaskList();
  Future<void> updateTaskList(List<Task> list);
  Future<Task> getTask(String id);
  Future<void> addTask(Task task);
  Future<void> updateTask(Task updatedTask);
  Future<void> deleteTask(String id);
}
