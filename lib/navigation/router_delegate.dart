import 'package:flutter/material.dart';
import 'package:school_todo_list/domain/entity/task.dart';
import 'package:school_todo_list/navigation/navigation_state.dart';
import 'package:school_todo_list/presentation/main_screen/main_screen.dart';
import 'package:school_todo_list/presentation/task_edit/task_edit_screen.dart';

class MyRouterDelegate extends RouterDelegate<NavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationState> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  Task? _selectedTask;
  bool? _isNewTask;

  @override
  NavigationState? get currentConfiguration {
    if (_isNewTask == true) {
      return NavigationState.newTask();
    }

    if (_selectedTask != null) {
      return NavigationState.editTask(_selectedTask!);
    }

    return NavigationState.root();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        const MaterialPage(
          key: ValueKey("TaskListScreen"),
          child: MainScreen(),
        ),
        if (_selectedTask != null)
          MaterialPage(
            key: ValueKey(_selectedTask!.id),
            child: TaskEditScreen(taskForEdit: _selectedTask),
          ),
        if (_isNewTask == true)
          const MaterialPage(
            key: ValueKey("NewTaskScreen"),
            child: TaskEditScreen(),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (_isNewTask == true) {
          _isNewTask = false;
        }

        if (_selectedTask != null) {
          _selectedTask = null;
        }

        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(NavigationState configuration) async {
    if (configuration.isEditTaskScreen) {
      _selectedTask = configuration.selectedTask;
    } else if (configuration.isNewTaskScreen) {
      _isNewTask = true;
    } else {
      _selectedTask = null;
      _isNewTask = false;
    }

    notifyListeners();
  }

  void showMainScreen() {
    _selectedTask = null;
    _isNewTask = false;
    notifyListeners();
  }

  void showEditTaskScreen(Task task) {
    _selectedTask = task;
    notifyListeners();
  }

  void showNewTaskScreen() {
    _isNewTask = true;
    notifyListeners();
  }
}
