part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthUser? authUser;
  const AuthState({this.authUser});

  @override
  List<Object?> get props => [authUser];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'authUser': authUser?.toMap() ?? {},
    };
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(
      authUser: AuthUser.fromMap(map['authUser']),
    );
  }
}

class AuthInitial extends AuthState {}

class AuthAuthenticateInProgress extends AuthState {}

class AuthAuthenticateSuccess extends AuthState {
  const AuthAuthenticateSuccess({super.authUser});
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
    super.authUser,
    this.statusCode = 200,
  });
}

class AuthUnauthenticateFailure extends AuthState {}
