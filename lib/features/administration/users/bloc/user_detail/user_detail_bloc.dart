import 'dart:core';

import '/common_libraries.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UsersRepository usersRepository;

  static String deleteErrorMessage =
      'There was an error while deleting site. Our team has been notified. Please wait a few minutes and try again.';
  UserDetailBloc({required this.usersRepository})
      : super(const UserDetailState()) {
    on<UserDetailUserLoadedById>(_onUserDetailUserLoadedById);
    on<UserDetailUserDeleted>(_onUserDetailUserDeleted);
  }

  Future<void> _onUserDetailUserLoadedById(
    UserDetailUserLoadedById event,
    Emitter<UserDetailState> emit,
  ) async {
    emit(state.copyWith(userLoadStatus: EntityStatus.loading));
    try {
      User user = await usersRepository.getUserById(event.userId);
      emit(state.copyWith(
        user: user,
        userLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        userLoadStatus: EntityStatus.failure,
      ));
    }
  }

  Future<void> _onUserDetailUserDeleted(
    UserDetailUserDeleted event,
    Emitter<UserDetailState> emit,
  ) async {
    emit(state.copyWith(userDeleteStatus: EntityStatus.loading));
    try {
      EntityResponse response = await usersRepository.deleteUser(event.userId);
      emit(state.copyWith(
        userDeleteStatus:
            response.isSuccess ? EntityStatus.success : EntityStatus.failure,
        message: response.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        userDeleteStatus: EntityStatus.failure,
        message: deleteErrorMessage,
      ));
    }
  }
}
