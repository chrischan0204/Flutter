part of 'user_invite_bloc.dart';

abstract class UserInviteEvent extends Equatable {
  const UserInviteEvent();

  @override
  List<Object> get props => [];
}

class UserInviteDetailsLoaded extends UserInviteEvent {
  final String userId;
  const UserInviteDetailsLoaded({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

class UserInviteInviteSent extends UserInviteEvent {
  final String userId;
  const UserInviteInviteSent({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

class UserInviteRegistered extends UserInviteEvent {
  final String userId;
  const UserInviteRegistered({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

class UserInviteAppDownloaded extends UserInviteEvent {
  final String userId;
  const UserInviteAppDownloaded({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}
