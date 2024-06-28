import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:school_todo_list/data/source/local/database.dart';
import 'package:school_todo_list/data/source/local/task_local_source.dart';
import 'package:school_todo_list/data/source/remote/api/api.dart';
import 'package:school_todo_list/data/source/remote/task_remote_source.dart';
import 'package:school_todo_list/data/task_repository_impl.dart';
import 'package:school_todo_list/domain/repository/task_repository.dart';
import 'package:school_todo_list/domain/usecase/task_usecase.dart';
import 'package:school_todo_list/l10n/app_localizations.dart';
import 'package:school_todo_list/logger.dart';
import 'package:school_todo_list/presentation/notifiers/task_list_notifier.dart';
import 'package:school_todo_list/presentation/themes.dart';
import 'package:school_todo_list/presentation/task_list/task_list_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  logger.d("Starting the app!");
  await initializeDateFormatting('ru_RU', null);
  WidgetsFlutterBinding.ensureInitialized();
  TaskRepository repo = await initRepo();

  runApp(
    MyApp(
      repository: repo,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.repository});

  final TaskRepository repository;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskListNotifier(
        TaskUseCase(repository: repository),
      )..loadTasks(),
      child: MaterialApp(
        title: 'Flutter Todo App',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ru'),
          Locale('en'),
        ],
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const TodoListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

Future<TaskRepository> initRepo() async {
  AppDatabaseImpl db = AppDatabaseImpl();
  await db.init();

  var repo = TaskRepositoryImpl(
    remoteSource: TaskRemoteSourceImpl(
      Api.instance.taskService,
      Api.instance.revisionHolder,
    ),
    database: TaskDatabaseImpl(db),
  );

  return repo;
}