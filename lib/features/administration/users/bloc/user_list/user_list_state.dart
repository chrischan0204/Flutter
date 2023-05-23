// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_list_bloc.dart';

class UserListState extends Equatable {
  final List<User> userList;
  final EntityStatus userListLoadStatus;
  final int totalRows;
  final String message;
  const UserListState({
    this.userList = const [],
    this.userListLoadStatus = EntityStatus.initial,
    this.message = '',
    this.totalRows = 0,
  });

  @override
  List<Object?> get props => [
        userList,
        userListLoadStatus,
        message,
        totalRows,
      ];

  UserListState copyWith({
    List<User>? userList,
    EntityStatus? userListLoadStatus,
    int? totalRows,
    String? message,
  }) {
    return UserListState(
      userList: userList ?? this.userList,
      userListLoadStatus: userListLoadStatus ?? this.userListLoadStatus,
      totalRows: totalRows ?? this.totalRows,
      message: message ?? this.message,
    );
  }
}
