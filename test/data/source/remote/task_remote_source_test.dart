import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_todo_list/data/dto/task_dto.dart';
import 'package:school_todo_list/data/source/remote/api/revision_holder.dart';
import 'package:school_todo_list/data/source/remote/api/services/task_service.dart';
import 'package:school_todo_list/data/source/remote/task_remote_source.dart';

import '../../dto/fake_task_dto.dart';
import 'api/responses/fake_response.dart';

class TaskServiceMock extends Mock implements TaskService {}

class RevisionHolderMock extends Mock implements RevisionHolder {}

void main() {
  late TaskService taskServiceMock;
  late RevisionHolder revisionHolderMock;
  late TaskRemoteSource remoteSource;

  setUp(() {
    registerFallbackValue(FakeTaskDto());

    taskServiceMock = TaskServiceMock();
    revisionHolderMock = RevisionHolderMock();

    when(() =>
            taskServiceMock.createTask(any(that: isA<Map<String, dynamic>>())))
        .thenAnswer((_) => Future.value(FakeElementResponse()));
    when(() => revisionHolderMock.saveRevision(any(that: isA<int>())))
        .thenAnswer((_) => Future.value());

    remoteSource = TaskRemoteSourceImpl(
      taskServiceMock,
      revisionHolderMock,
    );
  });

  group('TaskRemoteSource', () {
    test(
      'и его метод addTask должен обращаться к _taskService.createTask, '
      'сохранять ревизию и возвращать добавленную задачу',
      () async {
        // arrange

        // act
        var result = await remoteSource.addTask(FakeTaskDto());

        // assert
        verify(() => taskServiceMock
            .createTask(any(that: isA<Map<String, dynamic>>()))).called(1);
        verify(() => revisionHolderMock.saveRevision(any(that: isA<int>())))
            .called(1);

        expect(result, isA<TaskDto>());
      },
    );
  });
}
