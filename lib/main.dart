import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:school_todo_list/presentation/themes.dart';
import 'package:school_todo_list/presentation/task_list/task_list_screen.dart';

void main() async {
  await initializeDateFormatting('ru_RU', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo App',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const TodoListScreen(),
    );
  }
}
