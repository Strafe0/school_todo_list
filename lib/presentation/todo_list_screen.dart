import 'package:flutter/material.dart';
import 'package:school_todo_list/domain/task.dart';
import 'package:school_todo_list/presentation/themes.dart';

final todos = List.generate(
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

    return index % 2 == 0 ? Task(title: 'Купить хлеб') : Task(title: 'Купить молоко');
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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
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
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 28,),
              sliver: DecoratedSliver(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 2.0,
                      blurStyle: BlurStyle.normal,
                      color: shadow12,
                    ),
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 2.0,
                      blurStyle: BlurStyle.normal,
                      color: shadow6,
                    ),
                  ],
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Dismissible(
                        key: ValueKey(todos[index]),
                        direction: DismissDirection.horizontal,
                        background: Container(
                          color: Theme.of(context).colorScheme.secondary,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Icon(
                                Icons.check,
                                color: Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Theme.of(context).colorScheme.error,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: Icon(
                                Icons.delete,
                                color: Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ),
                        ),
                        onDismissed: (direction) {
                          debugPrint("Dismissible direction: $direction");
                        },
                        confirmDismiss: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            setState(() {
                              todos[index].toggle();
                            });
                          } else if (direction == DismissDirection.endToStart) {
                            setState(() {
                              todos.removeAt(index);
                            });
                          }

                          return Future.value(false);
                        },
                        child: CheckboxListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: todos[index].isCompleted,
                          onChanged: (bool? value) {
                            setState(() {
                              todos[index].toggle();
                            });
                          },
                          title: Text(
                            todos[index].title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              decoration: todos[index].isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          secondary: SizedBox(
                            height: 24,
                            width: 24,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: Icon(
                                Icons.info_outline,
                                color: Theme.of(context).colorScheme.tertiary,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: todos.length,
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
