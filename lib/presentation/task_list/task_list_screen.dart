import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:school_todo_list/domain/entity/task.dart';
import 'package:school_todo_list/l10n/l10n_extension.dart';
import 'package:school_todo_list/logger.dart';
import 'package:school_todo_list/presentation/task_edit/task_edit_screen.dart';
import 'package:school_todo_list/presentation/notifiers/task_list_notifier.dart';
import 'package:school_todo_list/presentation/task_list/fast_creation_text_field.dart';
import 'package:school_todo_list/presentation/task_list/task_list_screen_app_bar.dart';
import 'package:school_todo_list/presentation/task_list/task_list_tile.dart';
import 'package:school_todo_list/presentation/utils/shadow_box_decoration.dart';

class TaskMainScreen extends StatefulWidget {
  const TaskMainScreen({super.key});

  @override
  State<TaskMainScreen> createState() => _TaskMainScreenState();
}

class _TaskMainScreenState extends State<TaskMainScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey();

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
            return NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: MySliverAppBar(
                      expandedHeight: 148,
                      collapsedHeight: 88,
                    ),
                  ),
                ];
              },
              body: RefreshIndicator(
                key: _refreshKey,
                onRefresh: () => notifier.loadTasks(),
                child: CustomScrollView(
                  slivers: [
                    MainWidget(refreshIndicatorKey: _refreshKey),
                  ],
                ),
              ), 
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


class MainWidget extends StatelessWidget {
  const MainWidget({super.key, required this.refreshIndicatorKey});

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<TaskListNotifier>(context);

    if (notifier.isLoading) {
      assert(
        refreshIndicatorKey.currentState != null,
        "RefreshIndicatorState is null",
      );
      refreshIndicatorKey.currentState?.show();

      return const SliverFillRemaining();
    }
    
    if (notifier.isError) {
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
              onPressed: () => notifier.loadTasks(),
              child: Text(context.loc.buttonTryAgain),
            ),
          ],
        ),
      );
    } 

    if (notifier.filteredTasks.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Text(
            context.loc.taskListIsEmpty(notifier.showCompleted.toString()),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }

    return TaskList(
      tasks: notifier.filteredTasks,
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
