part of 'user_list_bloc.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();

  @override
  List<Object?> get props => [];
}

class UserListLoaded extends UserListEvent {}

class UserListSorted extends UserListEvent {
  final List<User> sortedUserList;

  const UserListSorted({required this.sortedUserList});
}

class UserListFiltered extends UserListEvent {
  final String filterId;
  final bool includeDeleted;
  final int? pageNum;
  final int? pageSize;
  const UserListFiltered({
    required this.filterId,
    this.includeDeleted = false,
    this.pageNum,
    this.pageSize,
  });

  @override
  List<Object?> get props => [
        filterId,
        includeDeleted,
        
      ];
}
