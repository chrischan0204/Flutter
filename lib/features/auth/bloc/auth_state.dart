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

class AuthAuthenticateFailure extends AuthState {}

class AuthUnauthenticateInProgress extends AuthState {}

class AuthUnauthenticateSuccess extends AuthState {
  const AuthUnauthenticateSuccess({required super.token});
}

class AuthUnauthenticateFailure extends AuthState {}
