// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthAuthenticated extends AuthEvent {
  final Auth auth;
  const AuthAuthenticated({
    required this.auth,
  });

  @override
  List<Object> get props => [auth];
}

class AuthUnauthenticated extends AuthEvent {
  final int? statusCode;
  const AuthUnauthenticated({
    this.statusCode,
  });
}
