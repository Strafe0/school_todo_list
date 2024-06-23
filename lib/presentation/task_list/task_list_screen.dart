import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_todo_list/domain/entity/importance.dart';
import 'package:school_todo_list/domain/entity/task.dart';
import 'package:school_todo_list/logger.dart';
import 'package:school_todo_list/presentation/task_edit/task_edit_screen.dart';
import 'package:school_todo_list/presentation/task_list/task_list_screen_app_bar.dart';
import 'package:school_todo_list/presentation/task_list/task_list_tile.dart';
import 'package:school_todo_list/presentation/utils/shadow_box_decoration.dart';

final allTasks = List.generate(
  30,
  (index) {
    if (index == 4) {
      return Task(
          title: 'Например, сейчас одна акция «Лукойла» стоит '
              'около 5700 рублей. Фьючерс на акции «Лукойла» — это, например, '
              'договор между покупателем и продавцом о том, что покупатель купит '
              'акции «Лукойла» у продавца по цене 5700 рублей через 3 месяца. '
              'При этом не важно, какая цена будет у акций через 3 месяца: '
              'цена сделки между покупателем и продавцом все равно останется 5700 рублей. '
              'Если реальная цена акции через три месяца не останется прежней, '
              'одна из сторон в любом случае понесет убытки.');
    }

    return index % 2 == 0
        ? Task(
            title: 'Купить хлеб',
            importance: index % 3 == 0 ? Importance.low : Importance.none,
            deadline: index % 4 == 0 ? DateTime.now() : null,
          )
        : Task(
            title: 'Купить молоко',
            importance: index % 5 == 0 ? Importance.high : Importance.none,
            deadline: index % 4 == 0 ? DateTime.now() : null,
          );
  },
);

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = [];
  final ValueNotifier<bool> completedTasksVisibility = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    tasks = allTasks;
  }

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
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: MySliverAppBar(
                expandedHeight: 148,
                collapsedHeight: 88,
                completedTasksVisibility: completedTasksVisibility,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: completedTasksVisibility,
              builder: (context, showCompletedTasks, child) {
                if (showCompletedTasks) {
                  tasks = allTasks;
                } else {
                  tasks = tasks.where((t) => !t.done).toList();
                }

                return TaskList(
                  tasks: tasks,
                  updateList: () => setState(() {}),
                );
              },
            ),
          ],
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
    required this.updateList,
  });

  final List<Task> tasks;
  final void Function() updateList;

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final _focusNode = FocusNode();

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
                return Padding(
                  padding: const EdgeInsets.only(left: 52.0, bottom: 8),
                  child: TextField(
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                      labelText: "Новое",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    onTapOutside: (event) => _focusNode.unfocus(),
                  ),
                );
              }

              return TaskListTile(
                task: widget.tasks[index],
                updateList: widget.updateList,
                remove: (id) {
                  logger.i(
                    "Deleting task ${widget.tasks[index].id}: "
                    "${widget.tasks[index].title}",
                  );
                  setState(() {
                    widget.tasks.removeWhere(
                      (t) => t.id == id,
                    );
                  });
                },
              );
            },
            childCount: widget.tasks.length + 1,
          ),
        ),
      ),
    );
  }
}
