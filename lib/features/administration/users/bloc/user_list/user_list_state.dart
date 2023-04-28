// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_list_bloc.dart';

class UserListState extends Equatable {
  final List<User> userList;
  final EntityStatus userListLoadStatus;
  final EntityStatus userLoadStatus;
  final String message;
  const UserListState({
    this.userList = const [],
    this.userListLoadStatus = EntityStatus.initial,
    this.userLoadStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        userList,
        userListLoadStatus,
        userLoadStatus,
        message,
      ];

  UserListState copyWith({
    List<User>? userList,
    EntityStatus? userListLoadStatus,
    User? selectedUser,
    EntityStatus? userLoadStatus,
    String? message,
  }) {
    return UserListState(
      userList: userList ?? this.userList,
      userListLoadStatus: userListLoadStatus ?? this.userListLoadStatus,
      message: message ?? this.message,
    );
  }
}
