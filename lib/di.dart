import 'package:get_it/get_it.dart';
import 'package:school_todo_list/data/offline/offline_manager.dart';
import 'package:school_todo_list/data/source/local/database.dart';
import 'package:school_todo_list/data/source/local/shared_prefs.dart';
import 'package:school_todo_list/data/source/local/task_local_source.dart';
import 'package:school_todo_list/data/source/remote/api/api.dart';
import 'package:school_todo_list/data/source/remote/connectivity.dart';
import 'package:school_todo_list/data/source/remote/task_remote_source.dart';
import 'package:school_todo_list/data/task_repository_impl.dart';
import 'package:school_todo_list/domain/repository/task_repository.dart';
import 'package:school_todo_list/domain/usecase/task_usecase.dart';

Future<void> setupDependecies() async {
  GetIt.I.registerSingleton<ConnectionChecker>(ConnectionChecker());

  GetIt.I.registerSingletonAsync<SharedPrefsManager>(() async {
    final prefs = SharedPrefsManager();
    await prefs.init();

    return prefs;
  });

  GetIt.I.registerSingletonAsync<TaskRepository>(() async {
    AppDatabaseImpl db = AppDatabaseImpl();
    await db.init();

    await GetIt.I.isReady<SharedPrefsManager>();
    final Api api = Api(GetIt.I.get<SharedPrefsManager>());

    return TaskRepositoryImpl(
      remoteSource: TaskRemoteSourceImpl(
        api.taskService,
        api.revisionHolder,
      ),
      database: TaskDatabaseImpl(db),
      connectionChecker: GetIt.I.get<ConnectionChecker>(),
    );
  });

  GetIt.I.registerSingletonAsync<TaskUseCase>(() async {
    await GetIt.I.isReady<TaskRepository>();

    return TaskUseCase(repository: GetIt.I.get<TaskRepository>());
  });

  GetIt.I.registerSingletonAsync<OfflineManager>(() async {
    await GetIt.I.isReady<TaskRepository>();

    return OfflineManager(
      repository: GetIt.I.get<TaskRepository>(),
      connectionChecker: GetIt.I.get<ConnectionChecker>(),
    );
  });

  await GetIt.I.allReady();
}
