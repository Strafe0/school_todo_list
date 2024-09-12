import 'package:mocktail/mocktail.dart';
import 'package:school_todo_list/data/source/remote/api/responses/response.dart';

class FakeResponse extends Fake implements TaskResponse {}

class FakeElementResponse extends Fake implements ElementResponse {
  @override
  int get revision => 0;

  @override
  Map<String, dynamic> get element => {
        "importance": "important",
        "deadline": 1721404800,
        "id": "testId",
        "text": "testTask",
        "last_updated_by": "123",
        "created_at": 1720349019,
        "changed_at": 1720349019,
        "done": true
      };
}
