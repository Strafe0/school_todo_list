class TaskDto {
  TaskDto({
    required this.id,
    required this.text,
    required this.importance,
    required this.deadline,
    required this.done,
    this.color,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
  });

  final String id;
  final String text;
  final String importance;
  final String deadline;
  final bool done;
  final String? color;
  final String createdAt;
  final String changedAt;
  final String lastUpdatedBy;
}
