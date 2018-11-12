import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_list_flutter_bloc/blocs/stats_bloc.dart';

class StatsCounter extends StatefulWidget {
  final StatsBloc Function() buildBloc;

  StatsCounter({Key key, @required this.buildBloc}) : super(key: key);

  @override
  _StatsCounterState createState() => _StatsCounterState();
}

class _StatsCounterState extends State<StatsCounter> {
  StatsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = widget.buildBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
