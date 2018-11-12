import 'package:my_todo_list_flutter_bloc/model/todo_entity.dart';

import 'reactive_repository.dart';
import 'filestorage.dart';
import 'webclient.dart';
import 'package:meta/meta.dart';

class TodosRepositoryFlutter implements TodosRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  TodosRepositoryFlutter({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  @override
  Future<List<TodoEntity>> loadTodos() async{
    try{
      return await  fileStorage.loadTodos();
    }catch(e){
      final todos = await webClient.fetchTodos();
      fileStorage.saveTodos(todos);
      return todos;
    }

  }

  @override
  Future saveTodos(List<TodoEntity> todos) {
    // TODO: implement saveTodos
    return null;
  }
}
