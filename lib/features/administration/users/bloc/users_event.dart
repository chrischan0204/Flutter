part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object?> get props => [];
}

class UsersRetrieved extends UsersEvent {}


class UserSelectedById extends UsersEvent {
  final String userId;
  const UserSelectedById({
    required this.userId,
  });
  @override
  List<Object?> get props => [
        userId,
      ];
}

class UserAdded extends UsersEvent {
  final User user;
  const UserAdded({
    required this.user,
  });
  @override
  List<Object?> get props => [
        user,
      ];
}

class UserEdited extends UsersEvent {
  final User user;
  const UserEdited({
    required this.user,
  });
  @override
  List<Object?> get props => [
        user,
      ];
}

class UserDeleted extends UsersEvent {
  final String userId;
  const UserDeleted({
    required this.userId,
  });
  @override
  List<Object?> get props => [
        userId,
      ];
}

class UsersSorted extends UsersEvent {
  final List<User> users;
  const UsersSorted({
    required this.users,
  });

  @override
  List<Object?> get props => [
        users,
      ];
}
