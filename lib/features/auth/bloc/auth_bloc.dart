import 'package:equatable/equatable.dart';

import '../../../common_libraries.dart';
import '../data/model/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthAuthenticated>(_onAuthAuthenticated);
    on<AuthUnauthenticated>(_onAuthUnauthenticated);
  }

  Future<void> _onAuthAuthenticated(
    AuthAuthenticated event,
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

  Future<void> _onAuthUnauthenticated(
    AuthUnauthenticated event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthUnauthenticateInProgress());
    try {
      await authRepository.logout();
      emit(AuthUnauthenticateSuccess(
          token: '', statusCode: event.statusCode ?? 200));
    } catch (e) {
      emit(AuthUnauthenticateFailure());
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toMap();
  }
}
