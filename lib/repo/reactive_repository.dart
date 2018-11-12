import 'package:my_todo_list_flutter_bloc/model/todo_entity.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:core';
import 'package:meta/meta.dart';

abstract class ReactiveTodosRepository {
  Future<void> addNewTodo(TodoEntity todo);

  Future<void> deleteTodo(List<String> idList);

  Stream<List<TodoEntity>> todos();

  Future<void> updateTodo(TodoEntity todo);
}

abstract class TodosRepository {
  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  Future<List<TodoEntity>> loadTodos();

  // Persists todos to local disk and the web
  Future saveTodos(List<TodoEntity> todos);
}

class ReactiveTodosRepositoryFlutter implements ReactiveTodosRepository {
  final TodosRepository _repository;
  final BehaviorSubject<List<TodoEntity>> _behaviorSubject;
  bool _loaded = false;

  ReactiveTodosRepositoryFlutter({
    @required TodosRepository repository,
    List<TodoEntity> seedValue,
  })  : this._repository = repository,
        this._behaviorSubject =
            BehaviorSubject<List<TodoEntity>>(seedValue: seedValue);

  @override
  Future<void> addNewTodo(TodoEntity todo) async {
    _behaviorSubject.add(List.unmodifiable([]
      ..addAll(_behaviorSubject.value ?? [])
      ..add(todo)));
    await _repository.saveTodos(_behaviorSubject.value);
  }

  @override
  Future<void> deleteTodo(List<String> idList) {
    // TODO: implement deleteTodo
    return null;
  }

  @override
  Stream<List<TodoEntity>> todos() {
    if (!_loaded) _loadTodos();
    return _behaviorSubject.stream;
  }

  @override
  Future<void> updateTodo(TodoEntity todo) {
    // TODO: implement updateTodo
    return null;
  }

  void _loadTodos() {
    _loaded = true;
    _repository.loadTodos().then((entities) {
      _behaviorSubject.add(List<TodoEntity>.unmodifiable(
        []..addAll(_behaviorSubject.value ?? [])..addAll(entities),
      ));
    });
  }
}
