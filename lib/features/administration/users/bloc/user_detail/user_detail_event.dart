part of 'user_detail_bloc.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

class UserDetailUserLoadedById extends UserDetailEvent {
  final String userId;
  const UserDetailUserLoadedById({required this.userId});

  @override
  List<Object> get props => [userId];
}

class UserDetailUserDeleted extends UserDetailEvent {
  final String userId;
  const UserDetailUserDeleted({
    required this.userId,
  });
  @override
  List<Object> get props => [userId];
}
