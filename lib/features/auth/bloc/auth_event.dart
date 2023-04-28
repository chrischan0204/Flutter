// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLogined extends AuthEvent {
  final Auth auth;
  const AuthLogined({
    required this.auth,
  });

  @override
  List<Object> get props => [auth];
}
