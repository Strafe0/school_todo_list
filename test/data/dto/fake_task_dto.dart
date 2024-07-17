import 'package:mocktail/mocktail.dart';
import 'package:school_todo_list/data/dto/task_dto.dart';

class FakeTaskDto extends Fake implements TaskDto {
  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}