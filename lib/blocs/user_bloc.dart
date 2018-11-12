import 'package:my_todo_list_flutter_bloc/repo/user_repository.dart';

class UserBloc {
  final UserRepository _repository;

  Stream<String> login() => _repository.login().asStream().asBroadcastStream();

  UserBloc(this._repository);
}
