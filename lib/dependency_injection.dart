import 'package:flutter/widgets.dart';
import 'repo/user_repository.dart';
import 'repo/todos_interactor.dart';

class Injector extends InheritedWidget {
  final TodosInteractor todosInteractor;
  final UserRepository userRepository;

  const Injector({
    Key key,
    @required TodosInteractor this.todosInteractor,
    @required UserRepository this.userRepository,
    @required Widget child,
  }) : super(key: key, child: child);

  static Injector of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(Injector);
  }

  @override
  bool updateShouldNotify(Injector old) {
    return userRepository != old.userRepository ||
        todosInteractor != old.todosInteractor;
  }
}
