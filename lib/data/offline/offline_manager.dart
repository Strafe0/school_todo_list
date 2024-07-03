import 'dart:async';

import 'package:school_todo_list/data/offline/update_event.dart';
import 'package:school_todo_list/data/source/remote/connectivity.dart';
import 'package:school_todo_list/domain/repository/task_repository.dart';

class OfflineManager {
  OfflineManager({required TaskRepository repository,
      required this.connectionChecker})
      : _repository = repository {
    _connectionSub = connectionChecker.connectionStream.listen(
      (bool hasConnection) async {
        if (hasConnection) {
          _streamController.add(UpdateStart());
          await _repository.updateOutdatedData();
          _streamController.add(UpdateEnd());
        }
      },
    );
  }

  final TaskRepository _repository;
  final ConnectionChecker connectionChecker;

  final StreamController<UpdateEvent> _streamController = StreamController();
  Stream<UpdateEvent> get updateEventStream => _streamController.stream;

  StreamSubscription<bool>? _connectionSub;

  void dispose() {
    _connectionSub?.cancel();
    _connectionSub = null;

    _streamController.close();
  }
}