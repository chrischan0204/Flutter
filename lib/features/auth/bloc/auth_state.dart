// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthAuthenticateInProgress extends AuthState {}

class AuthAuthenticateSuccess extends AuthState {
  final String token;
  const AuthAuthenticateSuccess({
    required this.token,
  });

  @override
  List<Object> get props => [token];
}

class AuthAuthenticateFailure extends AuthState {}
