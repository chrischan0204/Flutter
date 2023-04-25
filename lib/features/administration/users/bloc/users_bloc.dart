import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/data/model/model.dart';
import '/data/repository/repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository usersRepository;

  static String addErrorMessage =
      'There was an error while adding user. Our team has been notified. Please wait a few minutes and try again.';
  static String editErrorMessage =
      'There was an error while editing user. Our team has been notified. Please wait a few minutes and try again.';
  static String deleteErrorMessage =
      'There was an error while deleting user. Our team has been notified. Please wait a few minutes and try again.';
  UsersBloc({
    required this.usersRepository,
  }) : super(const UsersState()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<UsersRetrieved>(_onUsersRetrieved);
    on<UserSelected>(_onUserSelected);
    on<UserSelectedById>(_onUserSelectedById);
    on<UserAdded>(_onUserAdded);
    on<UserEdited>(_onUserEdited);
    on<UserDeleted>(_onUserDeleted);
    on<UsersStatusInited>(_onUsersStatusInited);
  }

  // get users list from repository
  Future<void> _onUsersRetrieved(
    UsersRetrieved event,
    Emitter<UsersState> emit,
  ) async {
    emit(state.copyWith(usersRetrievedStatus: EntityStatus.loading));
    try {
      List<User> users = await usersRepository.getUsers();
      emit(state.copyWith(
        users: users,
        usersRetrievedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(usersRetrievedStatus: EntityStatus.failure));
    }
  }

  // select user to add or edit
  void _onUserSelected(
    UserSelected event,
    Emitter<UsersState> emit,
  ) {
    emit(state.copyWith(selectedUser: event.selectedUser));
  }

  // get user details by id
  Future<void> _onUserSelectedById(
    UserSelectedById event,
    Emitter<UsersState> emit,
  ) async {
    emit(state.copyWith(
      userSelectedStatus: EntityStatus.loading,
    ));
    try {
      User selectedUser = await usersRepository.getUserById(event.userId);
      emit(state.copyWith(
        userSelectedStatus: EntityStatus.success,
        selectedUser: selectedUser,
      ));
    } catch (e) {
      emit(state.copyWith(
        userSelectedStatus: EntityStatus.failure,
        selectedUser: null,
      ));
    }
  }

  // add user
  Future<void> _onUserAdded(
    UserAdded event,
    Emitter<UsersState> emit,
  ) async {
    emit(state.copyWith(userCrudStatus: EntityStatus.loading));
    try {
      EntityResponse response = await usersRepository.addUser(event.user);
      if (response.isSuccess) {
        emit(state.copyWith(
          userCrudStatus: EntityStatus.success,
          message: response.message,
          selectedUser: state.selectedUser!.copyWith(id: response.data!.id),
        ));
      } else {
        emit(state.copyWith(
          userCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        userCrudStatus: EntityStatus.failure,
        message: addErrorMessage,
      ));
    }
  }

  // edit user
  Future<void> _onUserEdited(
    UserEdited event,
    Emitter<UsersState> emit,
  ) async {
    emit(state.copyWith(userCrudStatus: EntityStatus.loading));
    try {
      EntityResponse response = await usersRepository.editUser(event.user);
      if (response.isSuccess) {
        emit(state.copyWith(
          userCrudStatus: EntityStatus.success,
          message: response.message,
          selectedUser: state.selectedUser!.copyWith(id: response.data?.id),
        ));
      } else {
        emit(state.copyWith(
          userCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        userCrudStatus: EntityStatus.failure,
        message: addErrorMessage,
      ));
    }
  }

  // delete user
  Future<void> _onUserDeleted(
    UserDeleted event,
    Emitter<UsersState> emit,
  ) async {
    emit(state.copyWith(userCrudStatus: EntityStatus.loading));
    try {
      EntityResponse response = await usersRepository.deleteUser(event.userId);
      if (response.isSuccess) {
        emit(state.copyWith(
          userCrudStatus: EntityStatus.success,
          selectedUser: null,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          userCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        userCrudStatus: EntityStatus.failure,
        message: deleteErrorMessage,
      ));
    }
  }

  void _onUsersStatusInited(
    UsersStatusInited event,
    Emitter<UsersState> emit,
  ) {}
}
