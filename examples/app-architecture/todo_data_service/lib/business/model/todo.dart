import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

// #docregion Todo
@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    /// The unique identifier of the Todo item.
    required int id,

    /// The task description of the Todo item.
    required String task,
  }) = _Todo;
}

// #enddocregion Todo
