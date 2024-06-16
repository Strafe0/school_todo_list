class Task {
  Task({
    required this.title,
    this.importance = Importance.none,
    this.deadline,
  }) : _isCompleted = false;

  String title;
  Importance importance;
  DateTime? deadline;

  bool _isCompleted;
  bool get isCompleted => _isCompleted;

  void toggle() {
    _isCompleted = !_isCompleted;
  }
}

enum Importance {
  none, low, high
}