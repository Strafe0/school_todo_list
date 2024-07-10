import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:school_todo_list/data/offline/offline_manager.dart';
import 'package:school_todo_list/di.dart';
import 'package:school_todo_list/domain/usecase/task_usecase.dart';
import 'package:school_todo_list/l10n/app_localizations.dart';
import 'package:school_todo_list/logger.dart';
import 'package:school_todo_list/navigation/router_delegate.dart';
import 'package:school_todo_list/navigation/router_information_parser.dart';
import 'package:school_todo_list/presentation/notifiers/task_list_notifier.dart';
import 'package:school_todo_list/presentation/themes.dart';
import 'package:provider/provider.dart';

void main() async {
  logger.d("Starting the app!");
  await initializeDateFormatting('ru_RU', null);
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependecies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskListNotifier(
        GetIt.I.get<TaskUseCase>(),
        GetIt.I.get<OfflineManager>(),
      )..loadTasks(),
      child: MaterialApp.router(
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
        routerDelegate: MyRouterDelegate(),
        routeInformationParser: MyRouterInformationParser(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
