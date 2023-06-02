part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String username;
  final String usernameValidationmessage;

  final String password;
  final String passwordValidationMessage;

  final bool valid;
  const LoginState({
    this.username = '',
    this.usernameValidationmessage = '',
    this.password = '',
    this.passwordValidationMessage = '',
    this.valid = false,
  });

  @override
  List<Object> get props => [
        username,
        usernameValidationmessage,
        password,
        passwordValidationMessage,
        valid,
      ];

  LoginState copyWith({
    String? username,
    String? usernameValidationmessage,
    String? password,
    String? passwordValidationMessage,
    bool? valid,
  }) {
    return LoginState(
      username: username ?? this.username,
      usernameValidationmessage:
          usernameValidationmessage ?? this.usernameValidationmessage,
      password: password ?? this.password,
      passwordValidationMessage:
          passwordValidationMessage ?? this.passwordValidationMessage,
      valid: valid ?? this.valid,
    );
  }
}
