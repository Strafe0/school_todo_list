import 'package:flutter/material.dart';
import 'package:school_todo_list/domain/entity/importance.dart';
import 'package:school_todo_list/domain/entity/task.dart';
import 'package:school_todo_list/presentation/task_edit/task_edit_screen.dart';
import 'package:school_todo_list/presentation/task_list/task_list_tile.dart';
import 'package:school_todo_list/presentation/utils/shadow_box_decoration.dart';


final tasks = List.generate(
  30,
  (index) {
    if (index == 4) {
      return Task(title: 'Например, сейчас одна акция «Лукойла» стоит '
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: const CustomScrollView(
          slivers: [
            TaskListScreenAppBar(),
            TaskList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const TaskEditScreen(),
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class TaskListScreenAppBar extends StatelessWidget {
  const TaskListScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 148,
      collapsedHeight: 88,
      elevation: 4,
      shadowColor: Colors.grey,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          "Мои дела",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  const TaskList({super.key});

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
        decoration: boxDecorationWithShadow(
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index == tasks.length) {
                return Padding(
                  padding: const EdgeInsets.only(left: 72.0),
                  child: TextField(
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                      labelText: "Новое",
                      border: InputBorder.none,
                    ),
                    onTapOutside: (event) => _focusNode.unfocus(),
                  ),
                );
              }

              return TaskListTile(
                task: tasks[index],
                remove: (id) => tasks.removeWhere(
                  (t) => t.id == id,
                ),
              );
            },
            childCount: tasks.length + 1,
          ),
        ),
      ),
    );
  }
}