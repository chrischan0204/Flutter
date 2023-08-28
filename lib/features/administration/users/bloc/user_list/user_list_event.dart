part of 'user_list_bloc.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();

  @override
  List<Object?> get props => [];
}

/// event to load user list
class UserListLoaded extends UserListEvent {}

/// event to sort user list
class UserListSorted extends UserListEvent {
  final List<User> sortedUserList;

  const UserListSorted({required this.sortedUserList});
}

/// event to filter user list
class UserListFiltered extends UserListEvent {
  final FilteredTableParameter option;
  const UserListFiltered({
    required this.option,
  });

  @override
  List<Object?> get props => [option];
}
