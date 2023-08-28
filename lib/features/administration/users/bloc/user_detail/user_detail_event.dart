part of 'user_detail_bloc.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

/// event to load user detail by id
class UserDetailUserLoadedById extends UserDetailEvent {
  final String userId;
  const UserDetailUserLoadedById({required this.userId});

  @override
  List<Object> get props => [userId];
}

/// event to delete user by id
class UserDetailUserDeleted extends UserDetailEvent {
  final String userId;
  const UserDetailUserDeleted({
    required this.userId,
  });
  @override
  List<Object> get props => [userId];
}
