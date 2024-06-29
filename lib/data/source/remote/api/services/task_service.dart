import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:school_todo_list/data/source/remote/api/responses/response.dart';

part 'task_service.g.dart';

@RestApi()
abstract class TaskService {
  factory TaskService(Dio dio, {String baseUrl}) = _TaskService;

  @GET('/list')
  Future<ListResponse> getAll();

  @PATCH('/list')
  Future<ListResponse> updateAll(@Body() Map<String, dynamic> body);

  @GET('/list/{id}')
  Future<ElementResponse> getById(@Path('id') String id);

  @POST('/list')
  Future<ElementResponse> createTask(@Body() Map<String, dynamic> body);

  @PUT('/list/{id}')
  Future<ElementResponse> updateTask(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/list/{id}')
  Future<ElementResponse> deleteTask(@Path('id') String id);
}
