import 'package:flutter/material.dart';
import 'package:school_todo_list/presentation/themes.dart';
import 'package:school_todo_list/presentation/todo_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const TodoListScreen(),
    );
  }
}
