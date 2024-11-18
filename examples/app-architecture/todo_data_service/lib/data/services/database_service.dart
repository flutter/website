import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../business/model/todo.dart';
import '../../utils/result.dart';

class DatabaseService {
  DatabaseService({
    required this.databaseFactory,
  });

  final DatabaseFactory databaseFactory;

// #docregion Table
  static const _kTableTodo = 'todo';
  static const _kColumnId = '_id';
  static const _kColumnTask = 'task';
// #enddocregion Table

  Database? _database;

  bool isOpen() => _database != null;

// #docregion Open
  Future<void> open() async {
    _database = await databaseFactory.openDatabase(
      join(await databaseFactory.getDatabasesPath(), 'app_database.db'),
      options: OpenDatabaseOptions(
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE $_kTableTodo($_kColumnId INTEGER PRIMARY KEY AUTOINCREMENT, $_kColumnTask TEXT)',
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
      final id = await _database!.insert(_kTableTodo, {
        _kColumnTask: task,
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
        _kTableTodo,
        columns: [_kColumnId, _kColumnTask],
      );
      final list = entries
          .map(
            (element) => Todo(
              id: element[_kColumnId] as int,
              task: element[_kColumnTask] as String,
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
      final rowsDeleted = await _database!
          .delete(_kTableTodo, where: '$_kColumnId = ?', whereArgs: [id]);
      if (rowsDeleted == 0) {
        return Result.error(Exception('No todo found with id $id'));
      }
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
// #enddocregion Delete

  Future close() async {
    await _database?.close();
    _database = null;
  }
}
