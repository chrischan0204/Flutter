part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object?> get props => [];
}

class UsersRetrieved extends UsersEvent {}

class UserSelected extends UsersEvent {
  final User? selectedUser;
  const UserSelected({
    required this.selectedUser,
  });
  @override
  List<Object?> get props => [
        selectedUser,
      ];
}

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

class UsersStatusInited extends UsersEvent {}
