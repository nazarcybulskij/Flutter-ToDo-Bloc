import 'package:flutter/widgets.dart';
import 'todos_list_bloc.dart';

class TodosBlocProvider extends StatefulWidget {
  final Widget child;
  final TodosListBloc bloc;

  const TodosBlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  @override
  _TodosBlocProviderState createState() => _TodosBlocProviderState();

  static TodosListBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_TodosBlocProvider)
            as _TodosBlocProvider)
        .bloc;
  }
}

class _TodosBlocProviderState extends State<TodosBlocProvider> {
  @override
  Widget build(BuildContext context) {
    return _TodosBlocProvider(
      bloc: widget.bloc,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }
}

class _TodosBlocProvider extends InheritedWidget {
  final TodosListBloc bloc;

  const _TodosBlocProvider({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(key: key, child: child);

  static _TodosBlocProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(_TodosBlocProvider)
        as _TodosBlocProvider;
  }

  @override
  bool updateShouldNotify(_TodosBlocProvider old) {
    return true;
  }
}
