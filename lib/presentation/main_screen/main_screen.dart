import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:school_todo_list/logger.dart';
import 'package:school_todo_list/presentation/task_edit/task_edit_screen.dart';
import 'package:school_todo_list/presentation/notifiers/task_list_notifier.dart';
import 'package:school_todo_list/presentation/main_screen/body/main_screen_body.dart';
import 'package:school_todo_list/presentation/main_screen/main_screen_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    setSystemUIOverlayStyle();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Consumer<TaskListNotifier>(
          builder: (context, notifier, child) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
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
                    MainScreenBody(refreshIndicatorKey: _refreshKey),
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

  void setSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.surface,
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarColor: Theme.of(context).colorScheme.surface,
        systemNavigationBarDividerColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
