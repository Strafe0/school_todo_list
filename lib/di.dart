import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:school_todo_list/data/offline/offline_manager.dart';
import 'package:school_todo_list/data/source/local/database.dart';
import 'package:school_todo_list/data/source/local/shared_prefs.dart';
import 'package:school_todo_list/data/source/local/task_local_source.dart';
import 'package:school_todo_list/data/source/remote/api/api.dart';
import 'package:school_todo_list/data/source/remote/api/revision_holder.dart';
import 'package:school_todo_list/data/source/remote/connectivity.dart';
import 'package:school_todo_list/data/source/remote/remote_config_repository.dart';
import 'package:school_todo_list/data/source/remote/task_remote_source.dart';
import 'package:school_todo_list/data/task_repository_impl.dart';
import 'package:school_todo_list/domain/repository/task_repository.dart';
import 'package:school_todo_list/domain/usecase/task_usecase.dart';
import 'package:school_todo_list/logger.dart';

Future<void> setupDependencies() async {
  GetIt.I.registerSingleton<ConnectionChecker>(ConnectionChecker());

  GetIt.I.registerSingletonAsync<SharedPrefsManager>(() async {
    final prefs = SharedPrefsManager();
    await prefs.init();

    return prefs;
  });

  await GetIt.I.isReady<SharedPrefsManager>();

  GetIt.I.registerSingleton(RevisionHolder(GetIt.I.get<SharedPrefsManager>()));

  GetIt.I.registerSingletonAsync<TaskRepository>(() async {
    AppDatabaseImpl db = AppDatabaseImpl();
    await db.init();

    final Api api = Api(GetIt.I.get<SharedPrefsManager>());

    return TaskRepositoryImpl(
      remoteSource: TaskRemoteSourceImpl(
        api.taskService,
        api.revisionHolder,
      ),
      database: TaskDatabaseImpl(db),
      connectionChecker: GetIt.I.get<ConnectionChecker>(),
      revisionHolder: GetIt.I.get<RevisionHolder>(),
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

  GetIt.I.registerSingletonAsync<FirebaseRemoteConfig>(
    () async {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ));
      return remoteConfig;
    },
  );

  GetIt.I.registerSingletonAsync<RemoteConfigRepository>(() async {
    await GetIt.I.isReady<FirebaseRemoteConfig>();

    final configRepo = RemoteConfigRepository(
      GetIt.I.get<FirebaseRemoteConfig>(),
    );
    await configRepo.init();

    return configRepo;
  });

  await GetIt.I.allReady();

  _initCrashlytics();
}

void _initCrashlytics() {
  FlutterError.onError = (errorDetails) {
    logger.d('Caught error in FlutterError.onError');
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    logger.d('Caught error in PlatformDispatcher.onError');
    FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
    );
    return true;
  };
  logger.d('Crashlytics initialized');
}