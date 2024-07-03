import 'dart:io';

import 'package:school_todo_list/data/dto/task_dto.dart';
import 'package:school_todo_list/data/mappers/mappers.dart';
import 'package:school_todo_list/logger.dart';
import 'package:sqflite/sqflite.dart';

abstract class AppDatabase {
  Future<void> insertTask(TaskDto task);
  Future<void> updateTask(TaskDto task);
  Future<void> deleteTask(String id);
  Future<TaskDto> getTask(String id);
  Future<List<TaskDto>> getAll();
  Future<void> saveTaskList(List<TaskDto> list);
  Future<void> clearDatabase();
}

class AppDatabaseImpl implements AppDatabase {
  AppDatabaseImpl();

  static const String tableName = 'tasks';
  final int _version = 1;
  late final Database _db;

  Future<void> init() async {
    String path = await getDatabasesPath();
    _db = await openDatabase(
      "$path${Platform.pathSeparator}$tableName",
      version: _version,
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE IF NOT EXISTS $tableName ('
            'id TEXT PRIMARY KEY,'
            'text TEXT NOT NULL,'
            'importance TEXT NOT NULL,'
            'deadline INTEGER,'
            'done INTEGER NOT NULL,'
            'color TEXT,'
            'created_at INTEGER NOT NULL,'
            'changed_at INTEGER NOT NULL,'
            'last_updated_by TEXT NOT NULL)');
      },
    );
  }

  @override
  Future<void> insertTask(TaskDto taskDto) async {
    await _db.insert(
      tableName,
      taskDto.toDbJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<TaskDto> getTask(String id) async {
    try {
      List<Map> result = await _db.query(
        tableName,
        where: "id = ?",
        whereArgs: [id],
      );
      return TaskDto.fromDbJson(result.first as Map<String, dynamic>);
    } catch (error, stackTrace) {
      logger.e(
        "Database failed to get task",
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<List<TaskDto>> getAll() async {
    try {
      List<Map<String, dynamic>> result = await _db.query(tableName);
      return result.map((t) => TaskDto.fromDbJson(t)).toList();
    } catch (error, stackTrace) {
      logger.e(
        "Database failed to get all tasks",
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> saveTaskList(List<TaskDto> tasks) async {
    final batch = _db.batch();

    for (var task in tasks) {
      batch.insert(
        tableName,
        task.toDbJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<void> deleteTask(String id) async {
    await _db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }

  @override
  Future<void> updateTask(TaskDto task) async {
    await _db.update(
      tableName,
      task.toDbJson(),
      where: "id = ?",
      whereArgs: [task.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> clearDatabase() async {
    await _db.delete(tableName);
  }
}
