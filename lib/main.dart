import 'package:flutter/material.dart';
import 'dependency_injection.dart';
import 'package:my_todo_list_flutter_bloc/blocs/todos_bloc_provider.dart';
import 'package:my_todo_list_flutter_bloc/blocs/todos_list_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'routes.dart';
import 'screen/home_screen.dart';
import 'screen/add_edit_screen.dart';
import 'repo/user_repository.dart';
import 'repo/todos_interactor.dart';
import 'repo/reactive_repository.dart';
import 'repo/repository.dart';
import 'repo/filestorage.dart';

void main() {
  runApp(Injector(
    userRepository: AnonymousUserRepository(),
    todosInteractor: TodosInteractor(ReactiveTodosRepositoryFlutter(
        repository: TodosRepositoryFlutter(
            fileStorage: FileStorage(
                '__bloc_local_storage', getApplicationDocumentsDirectory)))),
    child: TodosBlocProvider(
        bloc: TodosListBloc(),
        child: MaterialApp(
          routes: {
            ArchSampleRoutes.home: (context) {
              return HomeScreen(
                userRepository: Injector.of(context).userRepository,
              );
            },
            ArchSampleRoutes.addTodo: (context) {
              return AddEditScreen();
            }
          },
        )),
  ));
}

class AnonymousUserRepository implements UserRepository {
  @override
  Future<String> login() => Future.delayed(Duration(seconds: 5), () => "login");
}
