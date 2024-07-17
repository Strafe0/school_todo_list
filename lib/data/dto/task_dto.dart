import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';

part 'task_dto.freezed.dart';
part 'task_dto.g.dart';

@freezed
class TaskDto extends Equatable with _$TaskDto {
  const TaskDto._();
  const factory TaskDto({
    required String id,
    required String text,
    required String importance,
    int? deadline,
    required bool done,
    String? color,
    @JsonKey(name: "created_at") required int createdAt,
    @JsonKey(name: "changed_at") required int changedAt,
    @JsonKey(name: "last_updated_by") required String lastUpdatedBy,
  }) = _TaskDto;

  factory TaskDto.fromJson(Map<String, dynamic> json) =>
      _$TaskDtoFromJson(json);

  factory TaskDto.fromDbJson(Map<String, dynamic> dbJson) {
    Map<String, dynamic> json = Map.of(dbJson);

    json["done"] = json["done"] == 1 ? true : false;

    return TaskDto.fromJson(json);
  }

  @override
  List<Object?> get props => [id];
}
