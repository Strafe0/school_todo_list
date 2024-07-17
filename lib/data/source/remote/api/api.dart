import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:school_todo_list/data/source/local/shared_prefs.dart';
import 'package:school_todo_list/data/source/remote/api/revision_holder.dart';
import 'package:school_todo_list/data/source/remote/api/services/task_service.dart';
import 'package:school_todo_list/data/source/remote/api/token_provider.dart';

class Api {
  Api(SharedPrefsManager prefs) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
        headers: {
          "Authorization": "Bearer ${getAccessToken()}",
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers["X-Last-Known-Revision"] =
              revisionHolder.localRevision;
          return handler.next(options);
        },
      ),
    );

    (_dio.httpClientAdapter as IOHttpClientAdapter)
        .createHttpClient = () => HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return host == "beta.mrdekk.ru";
      };

    taskService = TaskService(_dio);
    revisionHolder = RevisionHolder(prefs);
  }

  static const String baseUrl = "https://beta.mrdekk.ru/todo";

  late Dio _dio;
  late TaskService taskService;
  late RevisionHolder revisionHolder;
}
