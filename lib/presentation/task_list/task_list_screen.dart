import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:school_todo_list/domain/entity/task.dart';
import 'package:school_todo_list/logger.dart';
import 'package:school_todo_list/presentation/task_edit/task_edit_screen.dart';
import 'package:school_todo_list/presentation/notifiers/task_list_notifier.dart';
import 'package:school_todo_list/presentation/task_list/fast_creation_text_field.dart';
import 'package:school_todo_list/presentation/task_list/task_list_screen_app_bar.dart';
import 'package:school_todo_list/presentation/task_list/task_list_tile.dart';
import 'package:school_todo_list/presentation/utils/shadow_box_decoration.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).colorScheme.surface,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      systemNavigationBarColor: Theme.of(context).colorScheme.surface,
      systemNavigationBarDividerColor: Theme.of(context).colorScheme.surface,
    ));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Consumer<TaskListNotifier>(
          builder: (context, notifier, child) {
            Widget taskListWidget;
            if (notifier.isLoading) {
              taskListWidget = const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              taskListWidget = TaskList(
                tasks: notifier.filteredTasks,
              );
            }
        
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MySliverAppBar(
                    expandedHeight: 148,
                    collapsedHeight: 88,
                  ),
                ),
                taskListWidget,
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            logger.d("Go to TaskEditScreen for creation");
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TaskEditScreen(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  const TaskList({
    super.key,
    required this.tasks,
  });

  final List<Task> tasks;

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 28,
      ),
      sliver: DecoratedSliver(
        decoration: defaultBoxDecoration.copyWith(
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index == widget.tasks.length) {
                return const Padding(
                  padding: EdgeInsets.only(left: 52.0, bottom: 8),
                  child: FastCreationTextField(),
                );
              }

              return TaskListTile(
                task: widget.tasks[index],
              );
            },
            childCount: widget.tasks.length + 1,
          ),
        ),
      ),
    );
  }
}
