import 'package:equatable/equatable.dart';
import '/common_libraries.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginUsernameChanged>(_onLoginUsernameChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginValidationChecked>(_onLoginValidationChecked);
  }

  void _onLoginUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) =>
      emit(state.copyWith(
        username: event.username,
        usernameValidationmessage: '',
        valid: false,
      ));

  void _onLoginPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) =>
      emit(state.copyWith(
        password: event.password,
        passwordValidationMessage: '',
        valid: false,
      ));

  void _onLoginValidationChecked(
    LoginValidationChecked event,
    Emitter<LoginState> emit,
  ) {
    bool success = true;
    if (Validation.isEmpty(state.username)) {
      emit(state.copyWith(usernameValidationmessage: 'Username is required'));
      success = false;
    }

    if (Validation.isEmpty(state.password)) {
      emit(state.copyWith(passwordValidationMessage: 'Password is required'));

      success = false;
    }

    emit(state.copyWith(valid: success));
  }
}
