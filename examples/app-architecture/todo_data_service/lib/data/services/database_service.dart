import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../business/model/todo.dart';
import '../../utils/result.dart';

class DatabaseService {
  // #docregion Table
  static const String _todoTableName = 'todo';
  static const String _idColumnName = '_id';
  static const String _taskColumnName = 'task';
  // #enddocregion Table

  DatabaseService({required this.databaseFactory});

  final DatabaseFactory databaseFactory;

  Database? _database;

  bool isOpen() => _database != null;

  // #docregion Open
  Future<void> open() async {
    _database = await databaseFactory.openDatabase(
      join(await databaseFactory.getDatabasesPath(), 'app_database.db'),
      options: OpenDatabaseOptions(
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE $_todoTableName($_idColumnName INTEGER PRIMARY KEY AUTOINCREMENT, $_taskColumnName TEXT)',
          );
        },
        version: 1,
      ),
    );
  }
  // #enddocregion Open

  // #docregion Insert
  Future<Result<Todo>> insert(String task) async {
    try {
      final id = await _database!.insert(_todoTableName, {
        _taskColumnName: task,
      });
      return Result.ok(Todo(id: id, task: task));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
  // #enddocregion Insert

  // #docregion GetAll
  Future<Result<List<Todo>>> getAll() async {
    try {
      final entries = await _database!.query(
        _todoTableName,
        columns: [_idColumnName, _taskColumnName],
      );
      final list = entries
          .map(
            (element) => Todo(
              id: element[_idColumnName] as int,
              task: element[_taskColumnName] as String,
            ),
          )
          .toList();
      return Result.ok(list);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
  // #enddocregion GetAll

  // #docregion Delete
  Future<Result<void>> delete(int id) async {
    try {
      final rowsDeleted = await _database!.delete(
        _todoTableName,
        where: '$_idColumnName = ?',
        whereArgs: [id],
      );
      if (rowsDeleted == 0) {
        return Result.error(Exception('No todo found with id $id'));
      }
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
  // #enddocregion Delete

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}
