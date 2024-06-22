import 'package:school_todo_list/domain/entity/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
}
