import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:school_todo_list/di.dart';
import 'package:school_todo_list/main.dart';
import 'package:school_todo_list/presentation/main_screen/body/task_item.dart';
import 'package:uuid/uuid.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Быстрое создание с помощью текстового поля в конце списка задач',
    (tester) async {
      // arrange
      await setupDependencies();
      await tester.pumpWidget(const MyApp());
      String testTaskTitle = "TEST fast creation : ${const Uuid().v1()}";

      // act
      await tester.pumpAndSettle(const Duration(seconds: 3));
      await tester.enterText(find.byType(TextField), testTaskTitle);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // assert
      expect(
        find.byWidgetPredicate((widget) {
          return widget is TaskItem && widget.task.title == testTaskTitle;
        }),
        findsOne,
      );
    },
  );
}
