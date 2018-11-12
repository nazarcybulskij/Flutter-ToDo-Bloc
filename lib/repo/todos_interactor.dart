import 'dart:async';
import 'package:my_todo_list_flutter_bloc/repo/reactive_repository.dart';
import 'package:my_todo_list_flutter_bloc/model/todo.dart';

class TodosInteractor {
  final ReactiveTodosRepository repository;

  TodosInteractor(this.repository);

  Stream<List<Todo>> get todos {
    return repository
        .todos()
        .map((entites) => entites.map(Todo.fromEntity).toList());
  }
}
