import 'package:equatable/equatable.dart';
import 'package:safety_eta/common_libraries.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UsersRepository usersRepository;
  UserListBloc({required this.usersRepository}) : super(const UserListState()) {
    on<UserListLoaded>(_onUserListLoaded);
    on<UserListSorted>(_onUserListSorted);
  }

  Future<void> _onUserListLoaded(
    UserListLoaded event,
    Emitter<UserListState> emit,
  ) async {
    emit(state.copyWith(userListLoadStatus: EntityStatus.loading));
    try {
      List<User> userList = await usersRepository.getUsers();
      emit(state.copyWith(
        userListLoadStatus: EntityStatus.success,
        userList: userList,
      ));
    } catch (e) {
      emit(state.copyWith(userListLoadStatus: EntityStatus.failure));
    }
  }

  void _onUserListSorted(
    UserListSorted event,
    Emitter<UserListState> emit,
  ) {
    emit(state.copyWith(userList: event.sortedUserList));
  }
}
