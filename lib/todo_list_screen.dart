import 'package:flutter/material.dart';
import 'package:school_todo_list/themes.dart';

final todos = List.generate(
    30, (index) => index % 2 == 0 ? 'Купить хлеб' : 'Купить молоко');

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

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
                          return Future.value(false);
                        },
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          value: false,
                          onChanged: (bool? value) {},
                          title: Text(todos[index]),
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
