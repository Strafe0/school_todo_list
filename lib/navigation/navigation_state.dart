import 'package:school_todo_list/domain/entity/task.dart';

class NavigationState {
  bool _isEditTask = false;
  bool _isNewTask = false;
  Task? selectedTask;

  bool get isEditTaskScreen => _isEditTask;
  bool get isNewTaskScreen => _isNewTask;
  bool get isRoot => !isEditTaskScreen && !isNewTaskScreen;

  NavigationState(this.selectedTask);

  NavigationState.root()
      : _isNewTask = false,
        _isEditTask = false;

  NavigationState.newTask()
      : _isNewTask = true,
        selectedTask = null;

  NavigationState.editTask(Task task)
      : _isEditTask = true,
        selectedTask = task;
}
