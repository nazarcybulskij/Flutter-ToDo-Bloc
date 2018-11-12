import 'package:my_todo_list_flutter_bloc/repo/todos_interactor.dart';
import 'package:my_todo_list_flutter_bloc/model/todo.dart';

class StatsBloc {
  final Stream<int> numActive;
  final Stream<int> numComplete;

  StatsBloc._(this.numActive, this.numComplete);

  factory StatsBloc(TodosInteractor interactor) {
    return StatsBloc._(
      interactor.todos.map(_numActive),
      interactor.todos.map(_numComplete),
    );
  }

  static int _numActive(List<Todo> todos) {
    return todos.fold(0, (sum, todo) => !todo.complete ? ++sum : sum);
  }

  static int _numComplete(List<Todo> todos) {
    return todos.fold(0, (sum, todo) => todo.complete ? ++sum : sum);
  }
}
