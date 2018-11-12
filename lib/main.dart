import 'package:flutter/material.dart';
import 'dependency_injection.dart';
import 'package:my_todo_list_flutter_bloc/blocs/todos_bloc_provider.dart';
import 'package:my_todo_list_flutter_bloc/blocs/todos_list_bloc.dart';
import 'routes.dart';
import 'screen/home_screen.dart';
import 'screen/add_edit_screen.dart';
import 'repo/user_repository.dart';

void main() {
  runApp(Injector(
    userRepository: AnonymousUserRepository(),
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
