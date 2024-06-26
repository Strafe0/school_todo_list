import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:school_todo_list/data/source/remote/api/services/task_service.dart';
import 'package:school_todo_list/data/source/remote/api/token_provider.dart';

class Api {
  Api._() {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
      ),
    );

    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          String token = getAccessToken();
          options.headers["Authorization"] = "Bearer $token";
          return handler.next(options);
        },
      ),
    );

    (_dio!.httpClientAdapter as IOHttpClientAdapter)
        .createHttpClient = () => HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return host == "beta.mrdekk.ru";
      };

    taskService = TaskService(_dio!);
  }

  static final instance = Api._();

  static const String baseUrl = "https://beta.mrdekk.ru/todo";

  Dio? _dio;
  late TaskService taskService;
}
