import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:my_todo_list_flutter_bloc/repo/user_repository.dart';
import 'package:my_todo_list_flutter_bloc/keys.dart';
import 'package:my_todo_list_flutter_bloc/blocs/user_bloc.dart';
import 'package:my_todo_list_flutter_bloc/widget/loading.dart';
import 'package:my_todo_list_flutter_bloc/widget/stats_counter.dart';
import 'package:my_todo_list_flutter_bloc/widget/todo_list.dart';
import 'package:my_todo_list_flutter_bloc/blocs/stats_bloc.dart';
import 'package:my_todo_list_flutter_bloc/dependency_injection.dart';

enum AppTab { todos, stats }

class HomeScreen extends StatefulWidget {
  final UserRepository userRepository;

  HomeScreen({@required this.userRepository})
      : super(key: ArchSampleKeys.homeScreen);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserBloc userBloc;
  StreamController<AppTab> tabController;

  @override
  void initState() {
    super.initState();
    userBloc = UserBloc(widget.userRepository);
    tabController = StreamController<AppTab>();
  }

  @override
  void dispose() {
    tabController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: userBloc.login(),
      builder: (context, loginSnapshot) {
        return StreamBuilder<AppTab>(
          initialData: AppTab.todos,
          stream: tabController.stream,
          builder: (context, appTabSnashot) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Bloc Example'),
              ),
              body: loginSnapshot.hasData
                  ? appTabSnashot.data == AppTab.todos
                      ? TodoList()
                      : StatsCounter(
                          buildBloc: () =>
                              StatsBloc(Injector.of(context).todosInteractor),
                        )
                  : LoadingSpinner(),
              floatingActionButton: FloatingActionButton(
                key: ArchSampleKeys.addTodoFab,
                onPressed: () {
                  print('floating button press');
                },
                child: Icon(Icons.add),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: AppTab.values.indexOf(appTabSnashot.data),
                  onTap: (index) {
                    tabController.add(AppTab.values[index]);
                  },
                  items: AppTab.values.map((tab) {
                    return BottomNavigationBarItem(
                      icon: Icon(
                          tab == AppTab.todos ? Icons.list : Icons.show_chart),
                      title: Text(tab == AppTab.todos ? 'Todos' : 'Stats'),
                    );
                  }).toList()),
            );
          },
        );
      },
    );
  }
}
