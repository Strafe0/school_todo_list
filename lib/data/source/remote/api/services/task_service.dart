import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:school_todo_list/data/dto/task_dto.dart';
import 'package:school_todo_list/data/source/remote/api/response/response.dart';

part 'task_service.g.dart';

@RestApi()
abstract class TaskService {
  factory TaskService(Dio dio, {String baseUrl}) = _TaskService;

  @GET('/list')
  Future<ListResponse> getAll();

  @PATCH('/list')
  Future<ListResponse> updateAll(@Body() List<TaskDto> list);

  @GET('/list/{id}')
  Future<ElementResponse> getById(@Path('id') @Body() String id);

  @POST('/list')
  Future<ElementResponse> createTask(@Body() TaskDto task);

  @PUT('/list/{id}')
  Future<ElementResponse> updateTask(@Path('id') String id, TaskDto task);

  @DELETE('/list/{id}')
  Future<ElementResponse> deleteTask(@Path('id') String id);
}