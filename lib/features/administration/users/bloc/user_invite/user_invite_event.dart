part of 'user_invite_bloc.dart';

abstract class UserInviteEvent extends Equatable {
  const UserInviteEvent();

  @override
  List<Object> get props => [];
}

/// event to load user invite details
class UserInviteDetailsLoaded extends UserInviteEvent {
  final String userId;
  const UserInviteDetailsLoaded({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

/// event to send user invitation
class UserInviteInviteSent extends UserInviteEvent {
  final String userId;
  const UserInviteInviteSent({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

/// event to register invitation
class UserInviteRegistered extends UserInviteEvent {
  final String userId;
  const UserInviteRegistered({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

/// event to download app
class UserInviteAppDownloaded extends UserInviteEvent {
  final String userId;
  const UserInviteAppDownloaded({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}
