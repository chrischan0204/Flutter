import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:safety_eta/features/auth/data/repository/auth_repository.dart';

import '../data/model/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthLogined>(_onAuthLogined);
  }

  void _onAuthLogined(
    AuthLogined event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthAuthenticateInProgress());
    try {
      String token = await authRepository.login(event.auth);
      token = token.replaceAll('"', '');
      emit(AuthAuthenticateSuccess(token: token));
    } catch (e) {
      emit(AuthAuthenticateFailure());
    }
  }
}
