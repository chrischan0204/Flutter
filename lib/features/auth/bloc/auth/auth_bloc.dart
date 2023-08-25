
import '/common_libraries.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthAuthenticated>(_onAuthAuthenticated);
    on<AuthUnauthenticated>(_onAuthUnauthenticated);
  }

  @override
  void onChange(Change<AuthState> change) {
    // print(change.currentState);
    // print(change.nextState);
    super.onChange(change);
  }

  Future<void> _onAuthAuthenticated(
    AuthAuthenticated event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthAuthenticateInProgress());
    try {
      AuthUser authUser = await authRepository.login(event.auth);
      emit(AuthAuthenticateSuccess(authUser: authUser));
    } catch (e) {
      emit(const AuthAuthenticateFailure(message: 'Invalid Credendials'));
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
          authUser: null, statusCode: event.statusCode ?? 200));
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
