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
  }) : super(UserInitial()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<UsersRetrieved>(_onUsersRetrieved);
    on<UserSelectedById>(_onUserSelectedById);
    on<UserAdded>(_onUserAdded);
    on<UserEdited>(_onUserEdited);
    on<UserDeleted>(_onUserDeleted);
    on<UsersSorted>(_onUsersSorted);
  }

  // get users list from repository
  Future<void> _onUsersRetrieved(
    UsersRetrieved event,
    Emitter<UsersState> emit,
  ) async {
    emit(UserListLoadInProgress());
    try {
      List<User> users = await usersRepository.getUsers();
      emit(UserListLoadSuccess(users: users));
    } catch (e) {
      emit(UserListLoadFailure());
    }
  }

  void _onUsersSorted(
    UsersSorted event,
    Emitter<UsersState> emit,
  ) {
    emit(UserListLoadSuccess(users: event.users));
  }

  // get user details by id
  Future<void> _onUserSelectedById(
    UserSelectedById event,
    Emitter<UsersState> emit,
  ) async {
    emit(UserLoadByIdInProgress());
    try {
      User user = await usersRepository.getUserById(event.userId);
      emit(UserLoadByIdSuccess(user: user));
    } catch (e) {
      emit(UserLoadByIdFailure());
    }
  }

  // add user
  Future<void> _onUserAdded(
    UserAdded event,
    Emitter<UsersState> emit,
  ) async {
    emit(UserAddInProgress());
    try {
      EntityResponse response = await usersRepository.addUser(event.user);
      if (response.isSuccess) {
        emit(UserAddSuccess(message: response.message));
      } else {
        emit(UserAddFailure(message: response.message));
      }
    } catch (e) {
      emit(UserAddFailure(message: addErrorMessage));
    }
  }

  // edit user
  Future<void> _onUserEdited(
    UserEdited event,
    Emitter<UsersState> emit,
  ) async {
    emit(UserEditInProgress());
    try {
      EntityResponse response = await usersRepository.editUser(event.user);
      if (response.isSuccess) {
        emit(UserEditSuccess(message: response.message));
      } else {
        emit(UserEditFailure(message: response.message));
      }
    } catch (e) {
      emit(UserEditFailure(message: editErrorMessage));
    }
  }

  // delete user
  Future<void> _onUserDeleted(
    UserDeleted event,
    Emitter<UsersState> emit,
  ) async {
    emit(UserDeleteInProgress());
    try {
      EntityResponse response = await usersRepository.deleteUser(event.userId);
      if (response.isSuccess) {
        emit(UserDeleteSuccess(message: response.message));
      } else {
        emit(UserDeleteFailure(message: response.message));
      }
    } catch (e) {
      emit(UserDeleteFailure(message: deleteErrorMessage));
    }
  }
}
