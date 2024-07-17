import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_todo_list/domain/entity/task.dart';
import 'package:school_todo_list/l10n/l10n_extension.dart';
import 'package:school_todo_list/presentation/notifiers/task_list_notifier.dart';
import 'package:school_todo_list/presentation/main_screen/body/fast_creation_text_field.dart';
import 'package:school_todo_list/presentation/main_screen/body/task_item.dart';
import 'package:school_todo_list/presentation/utils/shadow_box_decoration.dart';

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({super.key, required this.refreshIndicatorKey});

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<TaskListNotifier>(context);

    if (notifier.isLoading) {
      return emptySpaceWithRefreshIndicator();
    }

    if (notifier.isError) {
      return const TaskLoadingError();
    }

    if (notifier.filteredTasks.isEmpty) {
      return const TaskListIsEmpty();
    }

    return TaskList(
      tasks: notifier.filteredTasks,
    );
  }

  Widget emptySpaceWithRefreshIndicator() {
    assert(
      refreshIndicatorKey.currentState != null,
      "RefreshIndicatorState is null",
    );
    refreshIndicatorKey.currentState?.show();

    return const SliverFillRemaining();
  }
}

class TaskLoadingError extends StatelessWidget {
  const TaskLoadingError({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.loc.errorLoadingTasks,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          TextButton(
            onPressed: () => Provider.of<TaskListNotifier>(
              context,
              listen: false,
            ).loadTasks(),
            child: Text(context.loc.buttonTryAgain),
          ),
        ],
      ),
    );
  }
}

class TaskListIsEmpty extends StatelessWidget {
  const TaskListIsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Text(
          context.loc.taskListIsEmpty(
            Provider.of<TaskListNotifier>(
              context,
              listen: false,
            ).showCompleted.toString(),
          ),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.tasks,
  });

  final List<Task> tasks;

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
              if (index == tasks.length) {
                return const Padding(
                  padding: EdgeInsets.only(
                    left: 48 + 8 + 4,
                    bottom: 8,
                    right: 48 + 8 + 4,
                  ),
                  child: FastCreationTextField(),
                );
              }

              return TaskItem(
                task: tasks[index],
              );
            },
            childCount: tasks.length + 1,
          ),
        ),
      ),
    );
  }
}
