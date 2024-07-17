import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:school_todo_list/di.dart';
import 'package:school_todo_list/main.dart';
import 'package:school_todo_list/presentation/main_screen/body/task_item.dart';
import 'package:uuid/uuid.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Создание задачи по нажатию на FAB', (tester) async {
    // arrange
    await setupDependencies();
    await tester.pumpWidget(const MyApp());
    String testTaskTitle = "TEST fab creation : ${const Uuid().v1()}";

    // act
    final fab = find.byType(FloatingActionButton);
    await tester.tap(fab);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), testTaskTitle);

    await tester.tap(find.byType(MenuAnchor));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('MenuItemButton_low')));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();
    await tester.tap(find.text('22'));
    await tester.tap(find.text('ОК'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey("SaveButton")));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // assert
    expect(
      find.byWidgetPredicate((widget) {
        return widget is TaskItem && widget.task.title == testTaskTitle;
      }),
      findsOne,
    );
  });
}
