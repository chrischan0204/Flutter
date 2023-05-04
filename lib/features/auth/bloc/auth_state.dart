// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String token;
  const AuthState({this.token = ''});

  @override
  List<Object> get props => [token];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
    };
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(token: map['token'] ?? '');
  }
}

class AuthInitial extends AuthState {}

class AuthAuthenticateInProgress extends AuthState {}

class AuthAuthenticateSuccess extends AuthState {
  const AuthAuthenticateSuccess({required super.token});
}

class AuthAuthenticateFailure extends AuthState {
  final String message;
  const AuthAuthenticateFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class AuthUnauthenticateInProgress extends AuthState {}

class AuthUnauthenticateSuccess extends AuthState {
  final int statusCode;
  const AuthUnauthenticateSuccess({
    required super.token,
    this.statusCode = 200,
  });
}

class AuthUnauthenticateFailure extends AuthState {}
