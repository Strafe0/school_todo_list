import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

class TaskResponse {
  TaskResponse(this.status, this.revision);

  final String status;
  final int revision;
}

@JsonSerializable()
class ListResponse extends TaskResponse {
  ListResponse(super.status, super.revision, this.list);

  List<Map<String, dynamic>> list;

  factory ListResponse.fromJson(Map<String, dynamic> json) =>
      _$ListResponseFromJson(json);
}

@JsonSerializable()
class ElementResponse extends TaskResponse {
  ElementResponse(super.status, super.revision, this.element);

  final Map<String, dynamic> element;

  factory ElementResponse.fromJson(Map<String, dynamic> json) =>
      _$ElementResponseFromJson(json);
}