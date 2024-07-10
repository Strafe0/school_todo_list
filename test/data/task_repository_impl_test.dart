import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_todo_list/data/dto/task_dto.dart';
import 'package:school_todo_list/data/source/local/task_local_source.dart';
import 'package:school_todo_list/data/source/remote/connectivity.dart';
import 'package:school_todo_list/data/source/remote/task_remote_source.dart';
import 'package:school_todo_list/data/task_repository_impl.dart';
import 'package:school_todo_list/domain/entity/importance.dart';
import 'package:school_todo_list/domain/entity/task.dart';
import 'package:school_todo_list/domain/repository/task_repository.dart';

import 'dto/fake_task_dto.dart';

class TaskDatabaseMock extends Mock implements TaskDatabaseImpl {}

class TaskRemoteSourceMock extends Mock implements TaskRemoteSourceImpl {}

class ConnectionCheckerMock extends Mock implements ConnectionChecker {}

void main() {
  late TaskDatabase db;
  late ConnectionChecker connectionChecker;
  late TaskRemoteSource remoteSourceMock;
  late TaskRepository repository;

  Task task = Task(
    id: 'taskId',
    title: 'test',
    importance: Importance.low,
    done: false,
    createdAt: DateTime(2024, 7, 10),
    changedAt: DateTime(2024, 7, 10),
  );

  setUp(() {
    registerFallbackValue(FakeTaskDto());

    remoteSourceMock = TaskRemoteSourceMock();
    db = TaskDatabaseMock();
    connectionChecker = ConnectionCheckerMock();

    // mock task creation
    when(() => remoteSourceMock.addTask(any(that: isA<TaskDto>())))
        .thenAnswer((_) => Future.value(FakeTaskDto()));
    when(() => db.addCachedTask(any(that: isA<TaskDto>())))
        .thenAnswer((_) => Future.value());

    // mock receiving task list
    when(() => remoteSourceMock.getTaskList())
        .thenAnswer((_) => Future.value([]));
    when(() => db.saveTaskList(any(that: isA<List<TaskDto>>())))
        .thenAnswer((_) => Future.value());
    when(() => db.getCachedTaskList()).thenAnswer((_) => Future.value([]));

    repository = TaskRepositoryImpl(
      remoteSource: remoteSourceMock,
      database: db,
      connectionChecker: connectionChecker,
    );
  });

  group('TodoRepositoryImpl', () {
    test(
        'и его метод addTask при наличии интернета должен отправлять задачу'
        'на сервер и сохранять возвращенную задачу в базу данных', () async {
      // arrange
      when(() => connectionChecker.hasConnection())
          .thenAnswer((_) async => Future.value(true));

      // act
      bool result = await repository.addTask(task);

      // assert
      verify(() => remoteSourceMock.addTask(any(that: isA<TaskDto>())))
          .called(1);
      verify(() => db.addCachedTask(any(that: isA<TaskDto>()))).called(1);

      expect(result, isTrue);
    });

    test(
        'и его метод addTask при отсутствии интернета '
        'должен сохранять задачу в базу данных', () async {
      // arrange
      when(() => connectionChecker.hasConnection())
          .thenAnswer((_) async => Future.value(false));

      // act
      bool result = await repository.addTask(task);

      // assert
      verifyNever(() => remoteSourceMock.addTask(any(that: isA<TaskDto>())));
      verify(() => db.addCachedTask(any(that: isA<TaskDto>()))).called(1);

      expect(result, isTrue);
    });

    test(
        'и его метод getTaskList при наличии интернета '
        'берет список задач с сервера, сохраняет его в БД, '
        'после чего возвращает список с БД', () async {
      // arrange
      when(() => connectionChecker.hasConnection())
          .thenAnswer((_) => Future.value(true));

      // act
      await repository.getTaskList();

      // assert
      verify(() => remoteSourceMock.getTaskList()).called(1);
      verify(() => db.saveTaskList(any(that: isA<List<TaskDto>>()))).called(1);
      verify(() => db.getCachedTaskList()).called(1);
    });

    test(
        'и его метод getTaskList при наличии интернета '
        'берет список задач с сервера, сохраняет его в БД, '
        'после чего возвращает список с БД', () async {
      // arrange
      when(() => connectionChecker.hasConnection())
          .thenAnswer((_) => Future.value(false));

      // act
      await repository.getTaskList();

      // assert
      verifyNever(() => remoteSourceMock.getTaskList());
      verifyNever(() => db.saveTaskList(any(that: isA<List<TaskDto>>())));
      verify(() => db.getCachedTaskList()).called(1);
    });
  });
}
