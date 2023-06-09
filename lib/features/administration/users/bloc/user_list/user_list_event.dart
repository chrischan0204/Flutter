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
  final FilteredTableParameter option;
  const UserListFiltered({
    required this.option,
  });

  @override
  List<Object?> get props => [option];
}
