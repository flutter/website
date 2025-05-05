import '../../business/model/todo.dart';
import '../../utils/result.dart';
import '../services/database_service.dart';

// #docregion TodoRepository
class TodoRepository {
  TodoRepository({required DatabaseService database}) : _database = database;

  final DatabaseService _database;

  Future<Result<List<Todo>>> fetchTodos() async {
    if (!_database.isOpen()) {
      await _database.open();
    }
    return _database.getAll();
  }

  Future<Result<Todo>> createTodo(String task) async {
    if (!_database.isOpen()) {
      await _database.open();
    }
    return _database.insert(task);
  }

  Future<Result<void>> deleteTodo(int id) async {
    if (!_database.isOpen()) {
      await _database.open();
    }
    return _database.delete(id);
  }
}

// #enddocregion TodoRepository
