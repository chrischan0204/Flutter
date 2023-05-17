part of 'user_list_bloc.dart';

class UserListState extends Equatable {
  final List<User> userList;
  final EntityStatus userListLoadStatus;
  final String message;
  const UserListState({
    this.userList = const [],
    this.userListLoadStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        userList,
        userListLoadStatus,
        message,
      ];

  UserListState copyWith({
    List<User>? userList,
    EntityStatus? userListLoadStatus,
    String? message,
  }) {
    return UserListState(
      userList: userList ?? this.userList,
      userListLoadStatus: userListLoadStatus ?? this.userListLoadStatus,
      message: message ?? this.message,
    );
  }
}
