// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_list_bloc.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();

  @override
  List<Object> get props => [];
}

class UserListLoaded extends UserListEvent {}

class UserListSorted extends UserListEvent {
  final List<User> sortedUserList;

  const UserListSorted({required this.sortedUserList});
}

class UserListFiltered extends UserListEvent {
  final String filterId;
  final bool includeDeleted;
  const UserListFiltered({
    required this.filterId,
    this.includeDeleted = false,
  });

  @override
  List<Object> get props => [
        filterId,
        includeDeleted,
      ];
}
