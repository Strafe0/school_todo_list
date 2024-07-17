import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:school_todo_list/env_config.dart';
import 'package:school_todo_list/logger.dart';
import 'package:school_todo_list/navigation/router_delegate.dart';
import 'package:school_todo_list/presentation/main_screen/body/offline_label.dart';
import 'package:school_todo_list/presentation/notifiers/task_list_notifier.dart';
import 'package:school_todo_list/presentation/main_screen/body/main_screen_body.dart';
import 'package:school_todo_list/presentation/main_screen/main_screen_app_bar.dart';
import 'package:school_todo_list/presentation/layout_manager.dart';

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
    final bool isPortrait = LayoutManager.isPortrait(context);
    final bool isTablet = LayoutManager.isTablet(context);

    Widget body = Consumer<TaskListNotifier>(
      builder: (context, notifier, child) {
        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverPersistentHeader(
                pinned: true,
                delegate: MySliverAppBar(
                  expandedHeight: isPortrait || isTablet ? 148 : 80,
                  collapsedHeight: isPortrait || isTablet ? 88 : 44,
                ),
              ),
            ];
          },
          body: RefreshIndicator(
            key: _refreshKey,
            onRefresh: () => notifier.loadTasks(),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: OfflineLabel(),
                ),
                MainScreenBody(refreshIndicatorKey: _refreshKey),
              ],
            ),
          ),
        );
      },
    );

    if (EnvConfig.isDevFlavor) {
      body = Banner(
        message: '[dev]',
        location: BannerLocation.topStart,
        child: body,
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: body,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            logger.d("Go to TaskEditScreen for creation");
            (Router.of(context).routerDelegate as MyRouterDelegate)
                .showNewTaskScreen();
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
